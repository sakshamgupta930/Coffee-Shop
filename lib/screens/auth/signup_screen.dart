import 'package:coffee_shop/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SignupScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        body: Stack(
      children: [
        // Positioned(
        //   bottom: -40,
        //   left: size.width * .04,
        //   child: SizedBox(
        //     height: size.height * .3,
        //     child: Image.asset(
        //       "assets/images/coffeeSplash.png",
        //     ),
        //   ),
        // ),
        SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: size.height * .13),
              child: Column(
                children: [
                  Text(
                    "Coffee Shop",
                    style: GoogleFonts.sora(
                      fontWeight: FontWeight.w500,
                      fontSize: 28,
                    ),
                  ),
                  SizedBox(height: size.height * .05),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    height: size.height * .6,
                    width: size.width * .85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Create Account",
                          style: GoogleFonts.sora(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: size.height * .04),
                        Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Username',
                                  hintStyle: GoogleFonts.sora(fontSize: 13),
                                  icon: const Icon(Iconsax.emoji_normal),
                                ),
                                controller: _nameController,
                              ),
                              SizedBox(height: size.height * .02),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Enter email',
                                  hintStyle: GoogleFonts.sora(fontSize: 13),
                                  icon: const Icon(Iconsax.personalcard),
                                ),
                                controller: _emailController,
                              ),
                              SizedBox(height: size.height * .02),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  focusColor: primaryColor,
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isVisible = !isVisible;
                                      });
                                    },
                                    child: isVisible
                                        ? const Icon(Iconsax.eye)
                                        : const Icon(Iconsax.eye_slash),
                                  ),
                                  hintStyle: GoogleFonts.sora(fontSize: 13),
                                  icon: const Icon(Iconsax.password_check),
                                ),
                                controller: _passwordController,
                                obscureText: isVisible ? false : true,
                              ),
                              SizedBox(height: size.height * .07),
                              Container(
                                height: size.height * .055,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: primaryColor),
                                child: Center(
                                  child: Text(
                                    "Create Account",
                                    style: GoogleFonts.sora(
                                        fontSize: 14, color: whiteColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: GoogleFonts.sora(fontSize: 12),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Login",
                                  style: GoogleFonts.sora(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
