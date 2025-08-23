import 'package:flutter/material.dart';

class HomeBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const HomeBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(0, 'assets/images/hh.png', 'Home'),
              _buildNavItem(1, 'assets/images/cart.png', 'Cars'),
              _buildNavItem(2, 'assets/images/Button.png', 'Create', isButton: true), // button
              _buildNavItem(3, 'assets/images/message.png', 'Chat'),
              _buildNavItem(4, 'assets/images/profile.png', 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String image, String label, {bool isButton = false}) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected && !isButton
              ? Colors.white.withOpacity(0.1)
              : Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              image,
              scale: 4,
              color: isButton ? null : Colors.white, // 👈 no white color for "Button"
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isButton
                    ? Colors.white // keep original for "Button"
                    : (isSelected ? Colors.white : Colors.white.withOpacity(0.7)),
                fontSize: 10,
                fontWeight: isSelected && !isButton ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
