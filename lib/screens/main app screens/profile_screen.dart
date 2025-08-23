import 'package:flutter/material.dart';
import 'package:tiktok/screens/main%20app%20screens/edit_profile_screen.dart';
import 'package:tiktok/screens/main%20app%20screens/help-center.dart';
import 'package:tiktok/screens/main%20app%20screens/notification-screen.dart';
import 'package:tiktok/screens/main%20app%20screens/post_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
final List<Map<String, dynamic>> cars = [
    {'name': 'Toyota Corolla', 'date': 'Aug 1, 2023', 'likes': 123},
    {'name': 'Honda Civic', 'date': 'Aug 5, 2023', 'likes': 98},
    {'name': 'BMW 3 Series', 'date': 'Aug 10, 2023', 'likes': 212},
    {'name': 'Tesla Model 3', 'date': 'Aug 15, 2023', 'likes': 145},
    
    {'name': 'Honda Civic', 'date': 'Aug 5, 2023', 'likes': 98},
    {'name': 'BMW 3 Series', 'date': 'Aug 10, 2023', 'likes': 212},
    {'name': 'Tesla Model 3', 'date': 'Aug 15, 2023', 'likes': 145},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              // Profile settings (like TikTok 3-dot menu)
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.black87,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (_) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      
                     
                      _buildBottomSheetItem(
                          Icons.notifications, "Notifications", () {
                              Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>NotificationsScreen()
        ),
      );
                          }),
                           _buildBottomSheetItem(Icons.edit, "Edit Profile", () {
                              Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>EditProfileScreen()
        ),
      );
                           }),
                      _buildBottomSheetItem(Icons.help, "Help & Support", () {
                          Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>HelpScreen()
        ),
      );
                      }),
                      _buildBottomSheetItem(Icons.logout, "Logout", () {
                         _buildLogoutButton(context);
                        // Navigator.pushReplacementNamed(context, '/login');
                      }),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          // ✅ Profile Info Section
          Column(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "John Doe",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const Text(
                "@johndoe123",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 16),

              // ✅ Stats Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem("Posts", "24"),
                  _buildStatItem("Followers", "156"),
                  _buildStatItem("Following", "89"),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),

          // ✅ Tab Bar (Videos & Posts)
          TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
            indicatorColor: Colors.red,
            tabs: const [
              Tab( text: "Videos"),
              Tab( text: "Posts"),
            ],
          ),
  const SizedBox(height: 20),
          // ✅ TabBar Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Videos Grid
                GridView.builder(
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                          image: AssetImage("assets/images/carcard.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),

                // Posts List (using CarCard style you made earlier)
                 GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two cards per row
                  crossAxisSpacing: 15, // Space between cards horizontally
                  mainAxisSpacing: 15, // Space between cards vertically
                  childAspectRatio: 1, // Adjust the aspect ratio to match the card
                ),
                itemCount: cars.length,
                itemBuilder: (context, index) {
                  final car = cars[index];
                  return GestureDetector(
                    onTap: (){
      //                  Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) =>CarDetailPage()
      //   ),
      // );
                    },
                    child: CarCard(
                      name: car['name'],
                      date: car['date'],
                      likes: car['likes'],
                    ),
                  );
                },
              ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
      ],
    );
  }

  Widget _buildBottomSheetItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      child: TextButton(
        onPressed: () {
          // Show confirmation dialog
          _showLogoutDialog(context);
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'logout',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
    void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text(
            'Logout',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
