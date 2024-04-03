import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class CoffeeCartCard extends StatelessWidget {
  final DocumentSnapshot coffeeData;
  const CoffeeCartCard({
    super.key,
    required this.coffeeData,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      height: size.height * .12,
      child: Row(
        children: [
          SizedBox(
            height: size.height * .1,
            width: size.width * .2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: NetworkImage(coffeeData['imageUrl']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                coffeeData['coffeeName'],
                style: GoogleFonts.sora(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    "${coffeeData['size']} - ",
                    style: GoogleFonts.sora(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "₹ ${coffeeData['price']}",
                    style: GoogleFonts.sora(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                coffeeData['withChocolate'],
                style: GoogleFonts.sora(
                  fontSize: 10,
                  color: greyColor,
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (coffeeData['quantity'] <= 1) {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser?.email)
                        .collection('cart')
                        .doc(coffeeData.id)
                        .delete();
                  } else {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser?.email)
                        .collection('cart')
                        .doc(coffeeData.id)
                        .update({'quantity': coffeeData['quantity'] - 1});
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: greyColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Iconsax.minus),
                ),
              ),
              const SizedBox(width: 10),
              Text(coffeeData['quantity'].toString()),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser?.email)
                      .collection('cart')
                      .doc(coffeeData.id)
                      .update({'quantity': coffeeData['quantity'] + 1});
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: greyColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Iconsax.add),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
