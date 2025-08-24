import 'package:flutter/material.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/gradient_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  String? nameError;
  String? emailError;
  String? phoneError;
  bool isLoading = false;

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    return RegExp(r'^\+?[\d\s-]{10,}$').hasMatch(phone);
  }

  void _validateAndContinue() {
    setState(() {
      nameError = null;
      emailError = null;
      phoneError = null;
    });

    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();

    bool isValid = true;

    if (name.isEmpty) {
      setState(() {
        nameError = 'Name is required';
      });
      isValid = false;
    } else if (name.length < 2) {
      setState(() {
        nameError = 'Name must be at least 2 characters';
      });
      isValid = false;
    }

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

    if (phone.isEmpty) {
      setState(() {
        phoneError = 'Phone number is required';
      });
      isValid = false;
    } else if (!_isValidPhone(phone)) {
      setState(() {
        phoneError = 'Please enter a valid phone number';
      });
      isValid = false;
    }

    if (isValid) {
      setState(() {
        isLoading = true;
      });
      
      // Simulate signup process
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
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 50),
               GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10, ) ,
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                   
                color: Color(0xFFFF6B81)
               
                 
                            
                  ),
                  child: Center(child: Icon(Icons.arrow_back_ios,size: 25,))),
              ),
 const SizedBox(height: 50),
              Center(child: Image.asset('assets/images/car.jpg',scale:4)),
              const SizedBox(height: 35),
              const Text(
                'Create your account',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 24),

              CustomTextField(
                controller: nameController,
                hintText: 'Name',
                errorText: nameError,
              ),
              if (nameError != null) ...[
                const SizedBox(height: 8),
                Text(
                  nameError!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ],
              const SizedBox(height: 16),

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
                controller: phoneController,
                hintText: 'Phone Number',
                errorText: phoneError,
              ),
              if (phoneError != null) ...[
                const SizedBox(height: 8),
                Text(
                  phoneError!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ],
              const SizedBox(height: 24),

              GradientButton(
                text: isLoading ? "Creating Account..." : "Continue",
                onPressed: isLoading ? null : _validateAndContinue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
