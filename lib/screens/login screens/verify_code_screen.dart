import 'package:flutter/material.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/otp_input_box.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final List<TextEditingController> otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final _formKey = GlobalKey<FormState>();
  
  String? otpError;
  bool isLoading = false;

  void _validateAndVerify() {
    setState(() {
      otpError = null;
    });

    final otp = otpControllers.map((controller) => controller.text).join();

    if (otp.length != 4) {
      setState(() {
        otpError = 'Please enter the complete 4-digit code';
      });
      return;
    }

    if (!RegExp(r'^\d{4}$').hasMatch(otp)) {
      setState(() {
        otpError = 'Please enter only numbers';
      });
      return;
    }

    setState(() {
      isLoading = true;
    });
    
    // Simulate OTP verification process
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
      Navigator.pushNamed(context, '/new-password');
    });
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
                "Enter the 4-digit code sent to your email",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => OTPInputBox(controller: otpControllers[index]),
                ),
              ),

              if (otpError != null) ...[
                const SizedBox(height: 16),
                Text(
                  otpError!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ],

              const SizedBox(height: 24),

              GradientButton(
                text: isLoading ? "Verifying..." : "Verify",
                onPressed: isLoading ? null : _validateAndVerify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
