import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/constants.dart';
import 'package:coffee_shop/widgets/coffee_cart_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  num price = 0;
  num totalPrice = 0;
  num couponDiscount = 0;
  final _addressController = TextEditingController();
  final bool _isLoading = false;
  final List<String> coupons = [
    'WELCOME',
    'SAVE10',
    'FREESHIP',
    '50OFF',
  ];
  final List<String> couponDetail = [
    'Save ₹149 with this code',
    'Save ₹10 with this code',
    'Save ₹99 with this code',
    'Save ₹50 with this code',
  ];
  final List<num> discountList = [149, 10, 99, 50];
  String selectedCoupon = '';

  Future<void> _getAddress() async {
    DocumentSnapshot addressSnapshot = await _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get();
    _addressController.text = addressSnapshot['address'];
  }

  @override
  void initState() {
    super.initState();
    _getAddress();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      // onVerticalDragDown: (_) {
      //   FocusScope.of(context).unfocus();
      // },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          backgroundColor: whiteColor,
          automaticallyImplyLeading: false,
          title: Text(
            "Cart",
            style: GoogleFonts.sora(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser?.email)
                        .collection('cart')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        List<DocumentSnapshot> coffeeList = snapshot.data!.docs;
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: coffeeList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CoffeeCartCard(
                                coffeeData: coffeeList[index]);
                          },
                        );
                      }
                    }),
                const Divider(height: 26),
                GestureDetector(
                  onTap: () {
                    _showCouponModal();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: greyColor),
                    ),
                    child: Row(
                      children: [
                        const Icon(Iconsax.percentage_square),
                        const SizedBox(width: 12),
                        selectedCoupon.isEmpty
                            ? Text(
                                "No coupon is applied",
                                style: GoogleFonts.sora(
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : Text(
                                "1 Coupon is applied",
                                style: GoogleFonts.sora(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                        const Spacer(),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  "Payment Summary",
                  style: GoogleFonts.sora(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Text(
                      "Price",
                      style: GoogleFonts.sora(),
                    ),
                    const Spacer(),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.email)
                            .collection('cart')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else {
                            price = 0;
                            for (int i = 0;
                                i < snapshot.data!.docs.length;
                                i++) {
                              price += snapshot.data!.docs[i]['price'];
                            }
                            return Text(
                              "₹ $price",
                              style: GoogleFonts.sora(
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                        }),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Text(
                      "Coupon Discount",
                      style: GoogleFonts.sora(),
                    ),
                    const Spacer(),
                    Text(
                      "-  ₹ $couponDiscount",
                      style: GoogleFonts.sora(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Text(
                      "Delivery Fee",
                      style: GoogleFonts.sora(),
                    ),
                    const Spacer(),
                    Text(
                      "Free",
                      style: GoogleFonts.sora(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 40,
                ),
                Row(
                  children: [
                    Text(
                      "Total Payment",
                      style: GoogleFonts.sora(),
                    ),
                    const Spacer(),
                    Text(
                      "₹ ${price - couponDiscount}",
                      style: GoogleFonts.sora(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 40),
                Text(
                  "Delivery Address",
                  style: GoogleFonts.sora(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: _addressController,
                    onChanged: (value) async {
                      await _firestore
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.email)
                          .update({'address': _addressController.text});
                    },
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Delivery Address",
                      hintStyle: GoogleFonts.sora(fontSize: 14),
                    ),
                  ),
                ),
                const Divider(height: 40),
                Row(
                  children: [
                    const Icon(Iconsax.money),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primaryColor,
                      ),
                      child: Text(
                        "Cash",
                        style: GoogleFonts.sora(
                          fontSize: 12,
                          color: whiteColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: greyColor.withOpacity(0.1),
                      ),
                      child: Text(
                        "₹ ${price - couponDiscount}",
                        style: GoogleFonts.sora(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: size.height * .07,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primaryColor),
                    child: Center(
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: whiteColor,
                            )
                          : Text(
                              "Order",
                              style: GoogleFonts.sora(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
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
      ),
    );
  }

  void _showCouponModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Text(
                "Coupons",
                style:
                    GoogleFonts.sora(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 6),
              ListView.builder(
                shrinkWrap: true,
                itemCount: coupons.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(
                      Iconsax.percentage_square,
                    ),
                    title: Text(
                      coupons[index],
                      style: GoogleFonts.sora(fontSize: 14),
                    ),
                    subtitle: Text(
                      couponDetail[index],
                      style: GoogleFonts.sora(fontSize: 10),
                    ),
                    tileColor: coupons[index] == selectedCoupon
                        ? primaryColor.withOpacity(0.5)
                        : null,
                    onTap: () {
                      setState(() {
                        selectedCoupon = coupons[index];
                        couponDiscount = discountList[index];
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
