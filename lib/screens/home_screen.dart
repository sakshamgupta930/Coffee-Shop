import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/bottom_nav_bar.dart';
import 'package:coffee_shop/constants.dart';
import 'package:coffee_shop/screens/coffee_details_screen.dart';
import 'package:coffee_shop/widgets/category_card.dart';
import 'package:coffee_shop/widgets/coffee_card.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position? _currentPosition;
  String? _currentAddress;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.name}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });

      print(_currentAddress);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
    FirebaseAnalytics.instance.logEvent(
      name: "Home_Screen",
      parameters: {
        'User': FirebaseAuth.instance.currentUser!.email,
      },
    );
  }
  // List<String> categories = [
  //   "Cappuccino",
  //   "Macchiato",
  //   "Espresso",
  //   "Flat white",
  //   "Latte",
  //   "Caffè mocha",
  //   "Americano",
  //   "Cold brew",
  //   "Cortado",
  // ];

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
                        Row(
                          children: [
                            Text(
                              "Location",
                              style: GoogleFonts.sora(
                                  color: whiteColor, fontSize: 14),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.place_outlined,
                              color: whiteColor,
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: width * .6,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _currentAddress ?? "Getting Location....",
                                  style: GoogleFonts.sora(
                                      color: whiteColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w200),
                                ),
                              ),
                            ],
                          ),
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
                const SearchBarHome(),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 16),
                //   child: SizedBox(
                //     height: height * .04,
                //     child: ListView.builder(
                //       physics: const BouncingScrollPhysics(),
                //       scrollDirection: Axis.horizontal,
                //       itemCount: categories.length,
                //       itemBuilder: (context, index) {
                //         return CategoryCard(category: categories[index]);
                //       },
                //     ),
                //   ),
                // ),
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

class SearchBarHome extends StatelessWidget {
  const SearchBarHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Padding(
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
    );
  }
}
