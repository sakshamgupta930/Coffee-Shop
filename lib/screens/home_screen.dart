import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/constants.dart';
import 'package:coffee_shop/screens/coffee_details_screen.dart';
import 'package:coffee_shop/widgets/category_card.dart';
import 'package:coffee_shop/widgets/coffee_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categories = [
    "Cappuccino",
    "Macchiato",
    "Espresso",
    "Flat white",
    "Latte",
    "Caffè mocha",
    "Americano",
    "Cold brew",
    "Cortado",
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: whiteColor,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: <Color>[Color(0XFF313131), Color(0XFF131313)],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 25, right: 25, top: height * .1),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Location",
                          style:
                              GoogleFonts.sora(color: whiteColor, fontSize: 12),
                        ),
                        Row(
                          children: [
                            Text(
                              "Morar, Gwalior",
                              style: GoogleFonts.sora(
                                  color: whiteColor, fontSize: 14),
                            ),
                            const SizedBox(width: 10),
                            const Icon(Iconsax.location, color: whiteColor)
                          ],
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      height: height * .055,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.asset("assets/images/profilePic.jpg"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * .03),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    padding: const EdgeInsets.only(left: 16, right: 4),
                    width: width,
                    height: height * .06,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.4),
                            spreadRadius: 1,
                            blurRadius: 4,
                            blurStyle: BlurStyle.outer),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Iconsax.search_normal),
                        const SizedBox(width: 10),
                        Text(
                          "Search Coffee",
                          style: GoogleFonts.sora(),
                        ),
                        const Spacer(),
                        Container(
                          height: height * .05,
                          width: width * .1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: primaryColor,
                          ),
                          child: const Icon(Iconsax.filter, color: whiteColor),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: SizedBox(
                    height: height * .05,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return CategoryCard(category: categories[index]);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('CoffeeList')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.data!.docs.isEmpty) {
                        return const Center(
                            child: Text('No coffee items available.'));
                      } else {
                        return GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: width * .1,
                            mainAxisExtent: height * .34,
                          ),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            var coffee = snapshot.data!.docs[index];
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      CoffeeDetailsScreen(coffee: coffee),
                                ),
                              ),
                              child: CoffeeCard(coffee: coffee),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
