import 'package:coffee_shop/constants.dart';
import 'package:coffee_shop/widgets/coffee_cart_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _addressController = TextEditingController();
  bool _isLoading = false;
  final List<String> coupons = [
    'WELCOME',
    'SAVE10',
    'FREESHIP',
    '50OFF',
  ];
  final List<String> couponDetail = [
    'Save ₹250 with this code',
    'Save ₹10 with this code',
    'Save ₹99 with this code',
    'Save ₹50 with this code',
  ];
  String selectedCoupon = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onVerticalDragDown: (_) {
        FocusScope.of(context).unfocus();
      },
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
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return const CoffeeCartCard();
                  },
                ),
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
                    Text(
                      "₹ 249",
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
                      "₹ 99",
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
                      "₹ 348",
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
                        "₹ 348",
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
