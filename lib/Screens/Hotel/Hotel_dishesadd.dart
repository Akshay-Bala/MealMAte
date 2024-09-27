import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HotelDishesadd extends StatefulWidget {
  @override
  _HotelDishesAddState createState() => _HotelDishesAddState();
}

class _HotelDishesAddState extends State<HotelDishesadd> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  File? _imageFile;

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
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            _buildImagePicker(),
            const SizedBox(height: 20),
            _buildTextField("Dish Name", _nameController, "Enter dish name"),
            const SizedBox(height: 20),
            _buildTextField("Price", _priceController, "Enter dish price",
              inputType: TextInputType.number,),
            const SizedBox(height: 20),
            _buildAddDishButton(),
          ],
        ),
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
      String label, TextEditingController controller, String errorText,
      {TextInputType inputType = TextInputType.text}) {
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
      print('uuu');
      Map<String, dynamic> data = {
        "Name of the dish": _nameController.text,
        "Price": _priceController.text,
       
      };
      await _saveDishToFirestore(data);
      // _clearForm();
    }
  }

  Future<String?> _uploadImage(File imageFile,data) async {
   final storageref=FirebaseStorage.instance.ref().child('dishes').child(imageFile.path.split('/').last);
   print("objectggg");
   await storageref.putFile(imageFile);
   final imgurl=await storageref.getDownloadURL();
   return imgurl;
  }

  Future<void> _saveDishToFirestore(Map<String, dynamic> data) async {
    if(_imageFile != null)
    data["imgurl"]=await _uploadImage(_imageFile!, data);
    print("object");
    try {
      await FirebaseFirestore.instance.collection("Dishes").add(data);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Dish added successfully")));
      Navigator.pop(context);
    } catch (e) {
      print('Error in saving dish: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed: ${e.toString()}")));
    }
  }

  // void _clearForm() {
  //   _nameController.clear();
  //   _priceController.clear();
  //   setState(() {
  //     _imageFile = null;
  //   });
  // }
}
