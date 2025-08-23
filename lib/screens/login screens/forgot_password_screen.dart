import 'package:flutter/material.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/gradient_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  String? emailError;
  bool isLoading = false;

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _validateAndContinue() {
    setState(() {
      emailError = null;
    });

    final email = emailController.text.trim();

    if (email.isEmpty) {
      setState(() {
        emailError = 'Email is required';
      });
      return;
    }

    if (!_isValidEmail(email)) {
      setState(() {
        emailError = 'Please enter a valid email';
      });
      return;
    }

    setState(() {
      isLoading = true;
    });
    
    // Simulate password reset process
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
      Navigator.pushNamed(context, '/verify-code');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Forgot Password?',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 12),
              const Text(
                'Enter your email address to reset your password.',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
              const SizedBox(height: 24),

              CustomTextField(
                controller: emailController,
                hintText: 'Email',
                errorText: emailError,
              ),
              if (emailError != null) ...[
                const SizedBox(height: 8),
                Text(
                  emailError!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ],
              const SizedBox(height: 24),

              GradientButton(
                text: isLoading ? "Sending..." : "Continue",
                onPressed: isLoading ? null : _validateAndContinue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
