import 'package:coffee_shop/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class CoffeeCard extends StatefulWidget {
  const CoffeeCard({super.key});

  @override
  State<CoffeeCard> createState() => _CoffeeCardState();
}

class _CoffeeCardState extends State<CoffeeCard> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).height;
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              height: height * .18,
              width: width * .18,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: const Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(coffeeImage),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cappucino",
                    style: GoogleFonts.sora(
                        fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "with Chocolate",
                    style: GoogleFonts.sora(color: greyColor, fontSize: 11),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₹ 249",
                        style: GoogleFonts.sora(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Container(
                        height: height * .04,
                        width: width * .04,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: primaryColor,
                        ),
                        child: const Icon(Iconsax.add, color: whiteColor),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: 0,
          height: 24,
          width: 45,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Colors.black26,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Iconsax.star1, color: Colors.amber, size: 14),
                  const SizedBox(width: 2),
                  Text(
                    "4.5",
                    style: GoogleFonts.sora(color: whiteColor, fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
