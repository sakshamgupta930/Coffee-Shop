import 'package:coffee_shop/constants.dart'; // Make sure this path is correct
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart'; // Ensure this package is correctly installed in pubspec.yaml

class SearchCoffeeCard extends StatefulWidget {
  final Map<String, dynamic> coffee;

  const SearchCoffeeCard({Key? key, required this.coffee}) : super(key: key);

  @override
  State<SearchCoffeeCard> createState() => _SearchCoffeeCardState();
}

class _SearchCoffeeCardState extends State<SearchCoffeeCard> {
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Stack(
            children: [
              SizedBox(
                width: width,
                height: height * .1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: height * .1,
                      width: width * .3,
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
                    const SizedBox(width: 16),
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
                            style: GoogleFonts.sora(
                                color: greyColor, fontSize: 11),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '₹ ${coffee['price']['M']}',
                            style: GoogleFonts.sora(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: height * .04,
                  width: width * .08,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: primaryColor,
                  ),
                  child: const Center(
                    child: Icon(Iconsax.add, color: whiteColor),
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
