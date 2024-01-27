import 'package:coffee_shop/bottom_nav_bar.dart';
import 'package:coffee_shop/constants.dart';
import 'package:coffee_shop/screens/auth/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              // Column(
              //   children: [
              //     ClipRRect(
              //       borderRadius: const BorderRadius.only(
              //         bottomLeft: Radius.circular(20),
              //         bottomRight: Radius.circular(20),
              //       ),
              //       child: Image.asset(
              //         "assets/images/loginCoffee.jpg",
              //       ),
              //     ),
              //     const Spacer(),
              //     Image.asset("assets/images/coffeeSplash.png"),
              //   ],
              // ),
              SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: size.height * .13),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "Coffee Shop",
                            style: GoogleFonts.sora(
                              fontWeight: FontWeight.w500,
                              fontSize: 28,
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * .05),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          height: size.height * .57,
                          width: size.width * .85,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Login",
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
                                        hintText: 'Enter email',
                                        hintStyle:
                                            GoogleFonts.sora(fontSize: 13),
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
                                        hintStyle:
                                            GoogleFonts.sora(fontSize: 13),
                                        icon:
                                            const Icon(Iconsax.password_check),
                                      ),
                                      controller: _passwordController,
                                      obscureText: isVisible ? false : true,
                                    ),
                                    SizedBox(height: size.height * .01),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          "Forgot password?",
                                          style: GoogleFonts.sora(
                                              fontSize: 12,
                                              color: primaryColor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: size.height * .02),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                BottomNavBarScreen(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: size.height * .055,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: primaryColor),
                                        child: Center(
                                          child: Text(
                                            "Login",
                                            style: GoogleFonts.sora(
                                                fontSize: 14,
                                                color: whiteColor),
                                          ),
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
                                      "Dont't have an account?",
                                      style: GoogleFonts.sora(fontSize: 12),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                const SignupScreen(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Create Account",
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
          ),
        ));
  }
}
