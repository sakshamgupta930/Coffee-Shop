import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class CoffeeCard extends StatefulWidget {
  final Map<String, dynamic> coffee;

  const CoffeeCard({Key? key, required this.coffee}) : super(key: key);

  @override
  State<CoffeeCard> createState() => _CoffeeCardState();
}

class _CoffeeCardState extends State<CoffeeCard> {
  late Map<String, dynamic> coffee;

  @override
  void initState() {
    super.initState();
    coffee = widget.coffee;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
              width: width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    coffee['image'],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coffee['name'],
                    style: GoogleFonts.sora(
                        fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    coffee['withChocolate'],
                    style: GoogleFonts.sora(color: greyColor, fontSize: 11),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹ ${coffee['price']['M']}',
                        style: GoogleFonts.sora(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Container(
                        height: height * .04,
                        width: width * .08,
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
            decoration: const BoxDecoration(
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
