import 'dart:io';

import 'package:coffee_shop/admin/coffee_list.dart';
import 'package:coffee_shop/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class CoffeeForm extends StatefulWidget {
  const CoffeeForm({super.key});

  @override
  _CoffeeFormState createState() => _CoffeeFormState();
}

class _CoffeeFormState extends State<CoffeeForm> {
  File? _image;
  final picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String _chocolateSelection = 'with Chocolate';

  bool isLoading = false;

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _saveCoffee() async {
    setState(() {
      isLoading = true;
    });
    if (_image != null) {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("coffee_images/${DateTime.now().millisecondsSinceEpoch}");
      UploadTask uploadTask = ref.putFile(_image!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      FirebaseFirestore.instance.collection('CoffeeList').add({
        'name': _nameController.text,
        'description': _descriptionController.text,
        'price': double.parse(_priceController.text),
        'image': imageUrl,
        'withChocolate': _chocolateSelection,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _nameController.clear();
      _descriptionController.clear();
      _priceController.clear();
      setState(() {
        _image = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Coffee saved successfully!'),
        ),
      );
      setState(() {
        isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an image.'),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee Form'),
        actions: [
          const Center(
            child: Text("Available"),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const CoffeeListPage(),
                  ));
            },
            icon: const Icon(Icons.coffee),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GestureDetector(
              onTap: _getImage,
              child: Container(
                width: size.width * .6,
                height: size.height * .25,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.black),
                ),
                child: _image != null
                    ? Image.file(_image!, fit: BoxFit.cover)
                    : const Center(
                        child: Text('Tap to select image'),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Coffee Name'),
            ),
            DropdownButtonFormField<String>(
              value: _chocolateSelection,
              items: [
                DropdownMenuItem(
                  child: Text('with Chocolate'),
                  value: 'with Chocolate',
                ),
                DropdownMenuItem(
                  child: Text('without Chocolate'),
                  value: 'without Chocolate',
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _chocolateSelection = value!;
                });
              },
              decoration: const InputDecoration(labelText: 'Chocolate'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _descriptionController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Price'),
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: size.height * .06,
              width: size.width,
              child: ElevatedButton(
                onPressed: _saveCoffee,
                child: isLoading
                    ? const CircularProgressIndicator(color: whiteColor)
                    : const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
