import 'package:flutter/material.dart';

class OTPInputBox extends StatelessWidget {
  final TextEditingController controller;

  const OTPInputBox({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white, fontSize: 20),
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          counterText: "",
          filled: true,
          fillColor: Colors.grey,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
