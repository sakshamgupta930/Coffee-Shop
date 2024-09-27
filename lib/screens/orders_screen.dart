import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('MMMM d, yyyy, h:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        title: Text(
          "My Orders",
          style: GoogleFonts.sora(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .where('customerEmail',
                  isEqualTo: FirebaseAuth.instance.currentUser!.email)
              // .orderBy('orderId', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final snapshotData = snapshot.data!.docs;
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshotData.length,
              itemBuilder: (BuildContext context, int index) {
                final orderData = snapshotData[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
                  child: Card(
                    elevation: 4,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: size.height * .08,
                                    width: size.width * .16,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image(
                                        image: orderData['orderStatus'] ==
                                                'Pending'
                                            ? const AssetImage(
                                                "assets/images/coffeePack.png")
                                            : const AssetImage(
                                                "assets/images/coffeeHeart.png"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Order ID",
                                        style: GoogleFonts.sora(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        orderData['orderId'],
                                        style: GoogleFonts.sora(
                                          fontSize: 10,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      SizedBox(
                                        width: size.width * .6,
                                        child: Text(
                                          orderData['customerAddress'],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: GoogleFonts.sora(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Divider(),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: orderData['items'].length,
                                itemBuilder: (BuildContext context, int index) {
                                  final itemData = orderData['items'][index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: size.height * .02,
                                          child: const Image(
                                            image: AssetImage(
                                                'assets/images/coffeePack.png'),
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          "${itemData['quantity'].toString()}x",
                                          style: GoogleFonts.sora(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          itemData['coffeeName'],
                                          style: GoogleFonts.sora(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          "[ ${itemData['size']} ]",
                                          style: GoogleFonts.sora(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    formatTimestamp(orderData['orderDate']),
                                    style: GoogleFonts.sora(
                                      fontSize: 10,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "₹ ${orderData['totalPrice']}",
                                    style: GoogleFonts.sora(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12,
                                    color: Colors.black54,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          top: size.height * .014,
                          right: size.width * .025,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: orderData['orderStatus'] == 'Delivered'
                                  ? const Color.fromARGB(255, 52, 156, 64)
                                  : primaryColor,
                            ),
                            child: Text(
                              orderData['orderStatus'],
                              style: GoogleFonts.sora(
                                color: whiteColor,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
