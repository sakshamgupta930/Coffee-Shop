import 'package:coffee_shop/constants.dart';
import 'package:coffee_shop/screens/cart_screen.dart';
import 'package:coffee_shop/screens/home_screen.dart';
import 'package:coffee_shop/screens/profile_screen.dart';
import 'package:coffee_shop/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int initialIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: GNav(
          activeColor: Colors.white,
          tabBackgroundColor: primaryColor,
          padding: const EdgeInsets.all(8),
          onTabChange: (index) {
            setState(() {
              initialIndex = index;
            });
          },
          gap: 8,
          textStyle: GoogleFonts.sora(color: whiteColor),
          tabs: const [
            GButton(
              icon: Iconsax.home,
              text: "Home",
            ),
            GButton(
              icon: Iconsax.search_normal,
              text: "Search",
            ),
            GButton(
              icon: Iconsax.shopping_bag,
              text: "Cart",
            ),
            GButton(
              icon: Iconsax.personalcard,
              text: "Profile",
            ),
          ],
        ),
      ),
      body: screens[initialIndex],
    );
  }
}
