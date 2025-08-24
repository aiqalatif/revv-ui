import 'package:flutter/material.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/gradient_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  String? emailError;
  String? passwordError;
  bool isLoading = false;

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPassword(String password) {
    return password.length >= 8;
  }

  void _validateAndLogin() {
    setState(() {
      emailError = null;
      passwordError = null;
    });

    final email = emailController.text.trim();
    final password = passwordController.text;

    bool isValid = true;

    if (email.isEmpty) {
      setState(() {
        emailError = 'Email is required';
      });
      isValid = false;
    } else if (!_isValidEmail(email)) {
      setState(() {
        emailError = 'Please enter a valid email';
      });
      isValid = false;
    }

    if (password.isEmpty) {
      setState(() {
        passwordError = 'Password is required';
      });
      isValid = false;
    } else if (!_isValidPassword(password)) {
      setState(() {
        passwordError = 'Password must be at least 8 characters';
      });
      isValid = false;
    }

    if (isValid) {
      setState(() {
        isLoading = true;
      });
      
      // Simulate login process
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isLoading = false;
        });
        Navigator.pushNamed(context, '/home');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [const SizedBox(height: 120),
              Center(child: Image.asset('assets/images/car.jpg',scale:4)),
              const SizedBox(height: 35),
              const Text(
                'Welcome Back!',
                style: TextStyle(fontSize: 18, color: Colors.white),
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
              const SizedBox(height: 16),

              CustomTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
                errorText: passwordError,
              ),
              if (passwordError != null) ...[
                const SizedBox(height: 8),
                Text(
                  passwordError!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ],
              const SizedBox(height: 8),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgot-password');
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              GradientButton(
                text: isLoading ? "Logging in..." : "Login",
                onPressed: isLoading ? null : _validateAndLogin,
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
