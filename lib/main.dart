import 'package:flutter/material.dart';
import 'screens/splash and onboarding/splash_screen.dart';
import 'screens/splash and onboarding/onboarding_screen1.dart';
import 'screens/splash and onboarding/onboarding_screen2.dart';
import 'screens/login screens/login_screen.dart';
import 'screens/login screens/signup_screen.dart';
import 'screens/login screens/forgot_password_screen.dart';
import 'screens/login screens/verify_code_screen.dart';
import 'screens/login screens/new_password_screen.dart';
import 'screens/main app screens/home_with_camera.dart';
import 'screens/main app screens/edit_profile_screen.dart';
import 'screens/main app screens/privacy_settings_screen.dart';

import 'demo_features.dart';

void main() {
  runApp(const RevvApp());
}

class RevvApp extends StatelessWidget {
  const RevvApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Revv App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding1': (context) => const OnboardingScreen(),
        '/onboarding2': (context) => const OnboardingScreen2(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/verify-code': (context) => const VerifyCodeScreen(),
        '/new-password': (context) => const NewPasswordScreen(),
        // 🔹 Home route now opens with updated navigation structure
        '/home': (context) => const HomeWithCameraSwipe(),
        // 🆕 Edit profile route
        '/edit-profile': (context) => const EditProfileScreen(),
        // 🆕 Privacy and settings route
        '/privacy-settings': (context) => const PrivacySettingsScreen(),
        // 🆕 Feature showcase route
        '/features': (context) => const RevvFeatureShowcase(),
      },
    );
  }
}
