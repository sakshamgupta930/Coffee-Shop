import 'package:coffee_shop/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Forgot Password",
              style: GoogleFonts.sora(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: size.height * .04),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter email',
                hintStyle: GoogleFonts.sora(fontSize: 13),
                icon: const Icon(Iconsax.personalcard),
              ),
              controller: _emailController,
            ),
            SizedBox(height: size.height * .04),
            Container(
              height: size.height * .055,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: primaryColor,
              ),
              child: Center(
                child: Text(
                  "Verify",
                  style: GoogleFonts.sora(fontSize: 14, color: whiteColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
