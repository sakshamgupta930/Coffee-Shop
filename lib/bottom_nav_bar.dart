import 'package:coffee_shop/constants.dart';
import 'package:coffee_shop/screens/cart/cart_screen.dart';
import 'package:coffee_shop/screens/home_screen.dart';
import 'package:coffee_shop/screens/orders_screen.dart';
import 'package:coffee_shop/screens/profile/profile_screen.dart';
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
    const HomeScreen(),
    const OrdersScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: GNav(
          activeColor: whiteColor,
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
              icon: Iconsax.activity,
              text: "My Orders",
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
