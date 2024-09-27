import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/screens/coffee_details_screen.dart';
import 'package:coffee_shop/screens/home_screen.dart';
import 'package:coffee_shop/screens/search_coffee_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        title: TextField(
          controller: searchController,
          onChanged: (value) {
            setState(() {});
          },
          decoration: InputDecoration(
            hintText: 'Search Coffee',
            hintStyle: GoogleFonts.sora(),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('CoffeeList').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final coffeeDocs = snapshot.data!.docs;
          final query = searchController.text.toLowerCase();
          final filteredCoffeeData = coffeeDocs.where((doc) {
            final name = doc['name'].toLowerCase();
            return name.contains(query);
          }).toList();

          if (filteredCoffeeData.isEmpty) {
            return Center(
                child: Text("No results found", style: GoogleFonts.sora()));
          }

          return ListView.builder(
            itemCount: filteredCoffeeData.length,
            itemBuilder: (BuildContext context, int index) {
              final coffeeData =
                  filteredCoffeeData[index].data() as Map<String, dynamic>;
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) =>
                        CoffeeDetailsScreen(coffee: coffeeData),
                  ),
                ),
                child: SearchCoffeeCard(coffee: coffeeData),
              );
            },
          );
        },
      ),
    );
  }
}
