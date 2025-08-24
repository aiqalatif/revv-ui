import 'package:flutter/material.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/gradient_button.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  String? newPasswordError;
  String? confirmPasswordError;
  bool isLoading = false;

  bool _isValidPassword(String password) {
    return password.length >= 8;
  }

  void _validateAndSave() {
    setState(() {
      newPasswordError = null;
      confirmPasswordError = null;
    });

    final newPassword = newPasswordController.text;
    final confirmPassword = confirmPasswordController.text;

    bool isValid = true;

    if (newPassword.isEmpty) {
      setState(() {
        newPasswordError = 'New password is required';
      });
      isValid = false;
    } else if (!_isValidPassword(newPassword)) {
      setState(() {
        newPasswordError = 'Password must be at least 8 characters';
      });
      isValid = false;
    }

    if (confirmPassword.isEmpty) {
      setState(() {
        confirmPasswordError = 'Please confirm your password';
      });
      isValid = false;
    } else if (newPassword != confirmPassword) {
      setState(() {
        confirmPasswordError = 'Passwords do not match';
      });
      isValid = false;
    }

    if (isValid) {
      setState(() {
        isLoading = true;
      });
      
      // Simulate password update process
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isLoading = false;
        });
        Navigator.pushNamed(context, '/login');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create a new password",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 24),

              CustomTextField(
                controller: newPasswordController,
                hintText: 'New Password',
                obscureText: true,
                errorText: newPasswordError,
              ),
              if (newPasswordError != null) ...[
                const SizedBox(height: 8),
                Text(
                  newPasswordError!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ],
              const SizedBox(height: 16),

              CustomTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
                errorText: confirmPasswordError,
              ),
              if (confirmPasswordError != null) ...[
                const SizedBox(height: 8),
                Text(
                  confirmPasswordError!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ],
              const SizedBox(height: 24),

              GradientButton(
                text: isLoading ? "Saving..." : "Save",
                onPressed: isLoading ? null : _validateAndSave,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
