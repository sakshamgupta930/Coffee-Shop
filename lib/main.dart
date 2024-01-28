import 'package:coffee_shop/constants.dart';
import 'package:coffee_shop/firebase_options.dart';
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
        primaryColor: whiteColor,
        colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor, background: whiteColor),
      ),
      home: const SplashScreen(),
    );
  }
}
