import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/constants.dart';
import 'package:coffee_shop/widgets/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoffeeDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> coffee;

  const CoffeeDetailsScreen({Key? key, required this.coffee}) : super(key: key);

  @override
  State<CoffeeDetailsScreen> createState() => _CoffeeDetailsScreenState();
}

class _CoffeeDetailsScreenState extends State<CoffeeDetailsScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance.collection('users');
  List<String> sizes = ['S', 'M', 'L'];
  late Map<String, dynamic> coffee;
  bool highlightColor = false;

  String selectedSize = 'M';

  @override
  void initState() {
    super.initState();
    coffee = widget.coffee;
  }

  Future<void> addToCart() async {
    try {
      String? uid = _auth.currentUser!.email;

      QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cart')
          .where('coffeeName', isEqualTo: coffee['name'])
          .limit(1)
          .get();

      if (cartSnapshot.docs.isNotEmpty) {
        Utils().toastMessage('Coffee is already in cart');
        return;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cart')
          .add({
        'coffeeName': coffee['name'],
        'withChocolate': coffee['withChocolate'],
        'price': coffee['price'][selectedSize].toDouble(),
        'size': selectedSize,
        'imageUrl': coffee['image'],
        'quantity': 1,
      });

      Utils().toastMessage('Added To Cart');
    } catch (e) {
      print('Error adding to cart: $e');
      Utils().toastMessage('Failed to add to cart');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          const Icon(Iconsax.heart, color: Colors.black),
          SizedBox(width: size.width * .05),
        ],
        title: Text(
          "Coffee Detail",
          style: GoogleFonts.sora(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: SizedBox(
                      height: size.height * .3,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          coffee['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: size.width * .6,
                            child: Text(
                              coffee['name'],
                              style: GoogleFonts.sora(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            coffee['withChocolate'],
                            style: GoogleFonts.sora(fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Iconsax.star1,
                              color: primaryColor, size: 28),
                          const SizedBox(width: 4),
                          Text(
                            "4.5",
                            style: GoogleFonts.sora(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                        ],
                      )
                    ],
                  ),
                  Divider(height: size.height * .05),
                  Text(
                    "Description",
                    style: GoogleFonts.sora(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ReadMoreText(
                    coffee['description'],
                    trimLines: 3,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Read more',
                    trimExpandedText: ' <-- Show less',
                    moreStyle: GoogleFonts.sora(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    lessStyle: GoogleFonts.sora(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    style: GoogleFonts.sora(fontSize: 14),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Size",
                    style: GoogleFonts.sora(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      for (int i = 0; i < sizes.length; i++)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSize = sizes[i];
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: selectedSize == sizes[i]
                                            ? primaryColor
                                            : Colors.grey),
                                    color: selectedSize == sizes[i]
                                        ? primaryColor.withOpacity(0.1)
                                        : null,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    sizes[i],
                                    style: GoogleFonts.sora(
                                      color: selectedSize == sizes[i]
                                          ? primaryColor
                                          : Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: size.height * .1,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price',
                        style: GoogleFonts.sora(
                            fontSize: 14, color: Colors.black54),
                      ),
                      Text(
                        '₹ ${coffee['price'][selectedSize]}',
                        style: GoogleFonts.sora(
                          fontSize: 20,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: addToCart,
                    onHighlightChanged: (value) {
                      setState(() {
                        highlightColor = value;
                      });
                    },
                    child: Container(
                      height: size.height * .06,
                      width: size.width * .45,
                      decoration: BoxDecoration(
                        color: highlightColor
                            ? primaryColor.withOpacity(.7)
                            : primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Add To Cart",
                          style: GoogleFonts.sora(
                            fontSize: 14,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
