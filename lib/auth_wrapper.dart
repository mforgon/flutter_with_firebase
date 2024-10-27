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
    // _checkCurrentUser();
    // Show the splash screen for 2 seconds
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isSplashScreenVisible = false;
      });
    });
  }

  // // Check if a user is currently logged in
  // void _checkCurrentUser() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     // User is signed in
  //     setState(() {
  //       _isSplashScreenVisible = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    if (_isSplashScreenVisible) {
      return const SplashScreen(); // Show the splash screen
    } else {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        return const HomePage(); // User is logged in
      } else {
        return const LoginPage(); // User is not logged in
      }
    }
  }
}
