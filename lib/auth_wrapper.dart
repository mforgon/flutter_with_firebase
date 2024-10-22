// lib/auth_wrapper.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'splashScreen/splashScreen.dart';


class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isSplashScreenVisible = true;

  @override
  void initState() {
    super.initState();
    // Show the splash screen for 3 seconds
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isSplashScreenVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isSplashScreenVisible) {
      return const SplashScreen(); // Show the splash screen
    } else {
      return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        },
      );
    }
  }
}
