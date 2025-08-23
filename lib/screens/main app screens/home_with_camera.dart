import 'package:flutter/material.dart';
import 'package:tiktok/screens/chat%20screens/chat_list_screen.dart';
import 'package:tiktok/screens/main%20app%20screens/camera_screen.dart';
import 'package:tiktok/screens/main%20app%20screens/home_screen.dart';
import 'package:tiktok/screens/main%20app%20screens/post_screen.dart';
import 'package:tiktok/screens/main%20app%20screens/profile_screen.dart';
import 'package:tiktok/widgets/home_bottom_navbar.dart';


class HomeWithCameraSwipe extends StatefulWidget {
  const HomeWithCameraSwipe({super.key});

  @override
  State<HomeWithCameraSwipe> createState() => _HomeWithCameraSwipeState();
}

class _HomeWithCameraSwipeState extends State<HomeWithCameraSwipe> {
  final PageController _pageController = PageController(
    initialPage: 0,
  ); // ✅ Start at Home
  int _currentIndex = 0; // ✅ Home index is now 1

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
           // ✅ Swipe LEFT from Home
          // ✅ Home (center)
           const HomeScreen(),
          PostCarScreen(),
          
          const CameraScreen(), // Cars
          const ChatListScreen(), // Chat
          const ProfileScreen(), // Profile
        ],
      ),
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }

  Widget _buildCarsTab() {
    return Container(
      color: Colors.black,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.directions_car, size: 80, color: Colors.white),
            SizedBox(height: 20),
            Text(
              'Cars',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Discover and explore cars',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
