import 'package:flutter/material.dart';

class CarDetailPage extends StatelessWidget {
  const CarDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Car Details"),
        backgroundColor: Colors.black,
        centerTitle: true,
        leading:   GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10 ) ,
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                     gradient: LinearGradient(
                colors: 
                  const [Colors.orange, Colors.pink]
                 
                            ), 
                  ),
                  child: Icon(Icons.arrow_forward_ios,size: 25,)),
              ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               
              const SizedBox(height: 50),
              // ✅ Status Chip
              
          
              // ✅ Car Image
              Image.asset(
                "assets/images/carcard.png",
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
          
              const SizedBox(height: 16),
          
              // ✅ Car Title + Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Tesla Model S 2023",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Electric car with autopilot, full option interior, and long range battery. Perfect condition, only 10,000 km driven.",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
          
              const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
                        "Location",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
          ),
                      const SizedBox(height: 10),
              // ✅ Map placeholder
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 180,
                   
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/images/map.png',))
                    ),
                  ),
                ),
              ),
          
              const SizedBox(height: 25),
          
              // ✅ User Info (Image + Name + Rating)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage("assets/images/user1.png"),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "John Doe",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: List.generate(5, (index) {
                            return const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            );
                          }),
                          
                        ),
                      ],
                    ),
                  const SizedBox(width: 100),
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.orange, Colors.pink],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: const Text(
                    "FOR SALE",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),  ],
                ),
              ),
          
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
