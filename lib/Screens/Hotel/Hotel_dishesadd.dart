import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:mealmate/Screens/login.dart';

class HotelDishesadd extends StatefulWidget {
  @override
  _HotelDishesAddState createState() => _HotelDishesAddState();
}

class _HotelDishesAddState extends State<HotelDishesadd> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  File? _imageFile;
  List<Map<String, dynamic>> _dishes = []; // To store added dishes

  @override
  void initState() {
    super.initState();
    _emailController.text = currentuserdata['email'] ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Dish")),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple, Colors.purpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  _buildImagePicker(),
                  const SizedBox(height: 20),
                  _buildTextField(
                      "Dish Name", _nameController, "Enter dish name"),
                  const SizedBox(height: 20),
                  _buildTextField(
                    "Price",
                    _priceController,
                    "Enter dish price",
                    inputType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    readOnly: true,
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: currentuserdata['email'],
                      labelStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.email, color: Colors.white),
                    ),
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  _buildAddDishButton(),
                  const SizedBox(height: 20),
                  const Divider(),
                  _buildDishList(), // Show added dishes here
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: () => _pickImage(ImageSource.gallery),
      child: _imageFile != null
          ? Image.file(_imageFile!, height: 150, fit: BoxFit.cover)
          : Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.add_a_photo, size: 50),
            ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    String errorText, {
    TextInputType inputType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.purpleAccent),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      keyboardType: inputType,
      validator: (value) {
        if (value == null || value.isEmpty) return errorText;
        return null;
      },
    );
  }

  Widget _buildAddDishButton() {
    return ElevatedButton(
      onPressed: _addDish,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: Colors.white,
      ),
      child: const Text(
        'Add Dish',
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _addDish() async {
    if (_formKey.currentState?.validate() ?? false && _imageFile != null) {
      Map<String, dynamic> data = {
        "name of the dish": _nameController.text,
        "price": _priceController.text,
        "email": currentuserdata['email'],
      };
      await _saveDishToFirestore(data);
      _clearForm();
    } else if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select an image")));
    }
  }

  Future<String?> _uploadImage(File imageFile) async {
    final storageRef = FirebaseStorage.instance.ref().child('dishes').child(
        '${DateTime.now().millisecondsSinceEpoch}_${imageFile.path.split('/').last}');
    await storageRef.putFile(imageFile);
    return await storageRef.getDownloadURL();
  }

  Future<void> _saveDishToFirestore(Map<String, dynamic> data) async {
    if (_imageFile != null) {
      data["imgurl"] = await _uploadImage(_imageFile!);
    }
    try {
      await FirebaseFirestore.instance.collection("Dishes").add(data);
      ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text("Dish added successfully")));

      setState(() {
        _dishes.add(data);
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed: ${e.toString()}")));
    }
  }

  Widget _buildDishList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("Dishes").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text(
            'No dishes added',
            style: TextStyle(color: Colors.white, fontSize: 16),
          );
        }

        var dishes = snapshot.data!.docs.map((doc) {
          return {
            "name of the dish": doc["name of the dish"],
            "price": doc["price"],
            "imgurl": doc["imgurl"],
            "email": doc["email"],
          };
        }).toList();

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: dishes.length,
          itemBuilder: (context, index) {
            final dish = dishes[index];
            return Card(
              color: Colors.white,
              child: ListTile(
                leading: dish["imgurl"] != null
                    ? Image.network(dish["imgurl"], width: 50, height: 50)
                    : const Icon(Icons.fastfood),
                title: Text(dish["name of the dish"]),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Price: \$${dish["price"]}"),
                    Text("Email: ${dish["email"]}"),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _priceController.clear();
    setState(() {
      _imageFile = null;
    });
  }
}
