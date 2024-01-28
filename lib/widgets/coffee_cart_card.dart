import 'package:coffee_shop/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class CoffeeCartCard extends StatelessWidget {
  const CoffeeCartCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      height: size.height * .1,
      child: Row(
        children: [
          SizedBox(
            height: size.height * .1,
            width: size.width * .14,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const Image(
                image: NetworkImage(coffeeImage),
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
                "Cappucino",
                style: GoogleFonts.sora(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "with Chocolate",
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
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: greyColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Iconsax.minus),
                ),
              ),
              const SizedBox(width: 10),
              const Text("1"),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {},
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
