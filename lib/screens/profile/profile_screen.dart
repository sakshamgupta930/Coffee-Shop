import 'package:coffee_shop/admin/coffee_form.dart';
import 'package:coffee_shop/constants.dart';
import 'package:coffee_shop/screens/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        title: Text(
          "My Profile",
          style: GoogleFonts.sora(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => CoffeeForm(),
                ),
              );
            },
            icon: const Icon(Icons.admin_panel_settings_outlined),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Profile Screen",
              style: GoogleFonts.sora(),
            ),
            ElevatedButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: const LoginScreen(),
                      type: PageTransitionType.fade),
                );
              },
              child: const Text("Logout"),
            )
          ],
        ),
      ),
    );
  }
}
