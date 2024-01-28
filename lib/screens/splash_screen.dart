import 'dart:async';
import 'package:coffee_shop/bottom_nav_bar.dart';
import 'package:coffee_shop/screens/auth/login_screen.dart';
import 'package:coffee_shop/screens/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void isLogin() {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(
          context,
          PageTransition(
            child: const BottomNavBarScreen(),
            type: PageTransitionType.fade,
          ),
        ),
      );
    } else {
      print("Login");
      Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(
          context,
          PageTransition(
            child: const OnBordingScreen(),
            type: PageTransitionType.fade,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Coffee Shop",
          style: GoogleFonts.sora(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
    );
  }
}
