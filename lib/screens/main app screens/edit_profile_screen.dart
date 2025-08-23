import 'package:flutter/material.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/gradient_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController(text: 'John Doe');
  final TextEditingController emailController = TextEditingController(text: 'john.doe@example.com');
  final TextEditingController phoneController = TextEditingController(text: '+1 234 567 8900');
  final TextEditingController bioController = TextEditingController(text: 'Car enthusiast and content creator');
  
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

  void _validateAndSave() {
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
      
      // Simulate save process
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isLoading = false;
        });
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading:  GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10 ) ,
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                     gradient: LinearGradient(
                colors: 
                  const [Colors.orange, Colors.pink]
                 
                            ), 
                  ),
                  child: Icon(Icons.arrow_forward_ios,size: 25,)),
              ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Color.fromARGB(255, 238, 181, 181)),
        ),
centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           SizedBox(height: 50,),
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                        ),
                        child: const CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Change Photo',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Form Fields
            const Text(
              'Personal Information',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            CustomTextField(
              controller: nameController,
              hintText: 'Full Name',
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
            const SizedBox(height: 16),

            CustomTextField(
              controller: bioController,
              hintText: 'Bio',
            ),
            const SizedBox(height: 24),

            // Save Button
            GradientButton(
              text: isLoading ? "Saving..." : "Save Changes",
              onPressed: isLoading ? null : _validateAndSave,
            ),
          ],
        ),
      ),
    );
  }
}
