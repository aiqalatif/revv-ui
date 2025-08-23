import 'package:flutter/material.dart';

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name and Last name',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text('Caption of the post #fyp', style: TextStyle(color: Colors.white)),
        Text(
          '🎵 Song name - song artist',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
