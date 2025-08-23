import 'package:flutter/material.dart';

class TopRightIcons extends StatelessWidget {
  const TopRightIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Icon(Icons.person_add_alt_1, color: Colors.white),
        SizedBox(height: 20),
        Icon(Icons.search, color: Colors.white),
      ],
    );
  }
}
