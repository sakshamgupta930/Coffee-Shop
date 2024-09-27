import 'package:coffee_shop/Notifications_firebase.dart';
import 'package:coffee_shop/constants.dart';
import 'package:coffee_shop/firebase_options.dart';
import 'package:coffee_shop/screens/splash_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseNotification notificationManager = FirebaseNotification();
  await notificationManager.initNotifications();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
        scaffoldBackgroundColor: whiteColor,
        appBarTheme: const AppBarTheme(backgroundColor: whiteColor),
        colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor, background: whiteColor),
      ),
      navigatorObservers: <NavigatorObserver>[
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
      ],
      home: const SplashScreen(),
    );
  }
}
