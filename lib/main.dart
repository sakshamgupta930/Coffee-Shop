import 'package:coffee_shop/firebase_options.dart';
import 'package:coffee_shop/screens/auth/login_screen.dart';
import 'package:coffee_shop/screens/onboarding_screen.dart';
import 'package:coffee_shop/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coffee Shop',
      theme: ThemeData(
        useMaterial3: false,
        primaryColor: Colors.black,
      ),
      home: const OnBordingScreen(),
    );
  }
}
