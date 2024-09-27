import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/bottom_nav_bar.dart';
import 'package:coffee_shop/constants.dart';
import 'package:coffee_shop/screens/home_screen.dart';
import 'package:coffee_shop/widgets/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
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
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  void createAccount() {
    setState(() {
      _isLoading = true;
    });
    Map<String, dynamic> userDetails = {
      // 'uid': _auth.currentUser!.uid.toString(),
      'email': _emailController.text,
      'name': _nameController.text,
      'createdAt': DateTime.now(),
      'address': "",
      'phoneNumber': "",
    };
    _auth
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
        .then((value) {
      _firestore
          .collection('users')
          .doc(_emailController.text)
          .set(userDetails);
      Utils().toastMessage("Account Created");
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => const BottomNavBarScreen(),
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        body: Stack(
      children: [
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
                    height: size.height * .7,
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
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter username';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Username',
                                  hintStyle: GoogleFonts.sora(fontSize: 13),
                                  icon: const Icon(Iconsax.emoji_normal),
                                ),
                                controller: _nameController,
                              ),
                              SizedBox(height: size.height * .02),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter email';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Enter email',
                                  hintStyle: GoogleFonts.sora(fontSize: 13),
                                  icon: const Icon(Iconsax.personalcard),
                                ),
                                controller: _emailController,
                              ),
                              SizedBox(height: size.height * .02),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter password';
                                  }
                                  return null;
                                },
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
                              GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    createAccount();
                                  }
                                },
                                child: Container(
                                  height: size.height * .055,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: primaryColor),
                                  child: Center(
                                    child: _isLoading
                                        ? const CircularProgressIndicator(
                                            color: whiteColor,
                                          )
                                        : Text(
                                            "Create Account",
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
