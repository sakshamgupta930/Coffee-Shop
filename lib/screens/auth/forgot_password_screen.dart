import 'package:coffee_shop/constants.dart';
import 'package:coffee_shop/widgets/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
  bool _isLoading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  void resetPassword() async{
    setState(() {
      _isLoading = true;
    });
    await _auth.sendPasswordResetEmail(email: _emailController.text).then((value) {
      Utils().toastMessage("Password Reset Email Sended");
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      setState(() {
        _isLoading = false;
      });
      Utils().toastMessage(error.toString());
    });
  } 

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
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
              SizedBox(height: size.height * .04),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    resetPassword();
                  }
                },
                child: Container(
                  height: size.height * .055,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: primaryColor,
                  ),
                  child: Center(
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: whiteColor,
                          )
                        : Text(
                            "Verify",
                            style: GoogleFonts.sora(
                                fontSize: 14, color: whiteColor),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
