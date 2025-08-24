import 'package:flutter/material.dart';
import 'package:tiktok/screens/chat%20screens/chat_list_screen.dart';

class CarDetailPage extends StatefulWidget {
  final String? sellerName;

  const CarDetailPage({super.key, this.sellerName});

  @override
  State<CarDetailPage> createState() => _CarDetailPageState();
}

class _CarDetailPageState extends State<CarDetailPage> {
  final TextEditingController _offerController = TextEditingController();

  /// ✅ Function to show Bid Popup
  void _showBidDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController bidController = TextEditingController();

        return AlertDialog(
          backgroundColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            "Place Your Bid",
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: bidController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Enter your offer amount",
              hintStyle: const TextStyle(color: Colors.white54),
              filled: true,
              fillColor: Colors.grey[900],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          actions: [
                Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.orange, Colors.pink],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () => Navigator.pop(context),
        child: const Text(
          "Cancel",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
            Container(
               decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.orange, Colors.pink],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  if (bidController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Please enter your bid amount")),
                    );
                    return;
                  }
              
                  Navigator.pop(context); // Close dialog
              
                  // ✅ Navigate to ChatListScreen after placing bid
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatListScreen(),
                    ),
                  );
                },
                child: const Text("Send Offer", style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Car Details"),
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFFF6B81),
            ),
            child: const Center(
              child: Icon(Icons.arrow_back_ios, size: 20),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),

            // ✅ Car Image
            Image.asset(
              "assets/images/carcard.png",
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 16),

            // ✅ Title + Description
            const Text(
              "Tesla Model S 2023",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              "Electric car with autopilot, long range battery. Perfect condition, only 10,000 km driven.",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),

            const SizedBox(height: 20),

            // ✅ Map Placeholder
            const Text(
              "Location",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                "assets/images/map.png",
                height: 180,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 30),

            // ✅ Seller Info
            Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage("assets/images/user1.png"),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("John Doe",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    Row(
                      children: List.generate(
                        5,
                        (index) =>
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                      ),
                    )
                  ],
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    gradient:
                        const LinearGradient(colors: [Colors.orange, Colors.pink]),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text("FOR SALE",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                )
              ],
            ),

            const SizedBox(height: 40),

            // ✅ Place Bid Button
            Center(
  child: Container(
    width: double.infinity, // full width
    margin: const EdgeInsets.symmetric(horizontal: 20), // side space
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Colors.orange, Colors.pink],
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: ElevatedButton(
      onPressed: _showBidDialog,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent, // transparent for gradient
        shadowColor: Colors.transparent, // remove shadow
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text(
        "Place Bid",
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
