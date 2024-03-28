import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoffeeListPage extends StatefulWidget {
  const CoffeeListPage({Key? key}) : super(key: key);

  @override
  _CoffeeListPageState createState() => _CoffeeListPageState();
}

class _CoffeeListPageState extends State<CoffeeListPage> {
  String _chocolateFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              value: _chocolateFilter,
              items: const [
                DropdownMenuItem(
                  value: 'All',
                  child: Text('All'),
                ),
                DropdownMenuItem(
                  value: 'with Chocolate',
                  child: Text('with Chocolate'),
                ),
                DropdownMenuItem(
                  value: 'without Chocolate',
                  child: Text('without Chocolate'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _chocolateFilter = value!;
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder(
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
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var coffee = snapshot.data!.docs[index];
                      if (_chocolateFilter == 'All' ||
                          coffee['chocolate'] == _chocolateFilter) {
                        return ListTile(
                          title: Text(coffee['name']),
                          subtitle: Text(coffee['description']),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(coffee['image']),
                          ),
                          trailing: Text('₹${coffee['price']}'),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
