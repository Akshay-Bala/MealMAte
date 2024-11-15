import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HotelSignup extends StatefulWidget {
  HotelSignup({Key? key}) : super(key: key);

  @override
  State<HotelSignup> createState() => _HotelSignupState();
}

class _HotelSignupState extends State<HotelSignup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _file;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _file = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade100, Colors.indigo.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Card(
              elevation: 8,
              shadowColor: Colors.indigo.withOpacity(0.4),
              color: Colors.indigo.withOpacity(0.85),
              margin: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Register Your Hotel',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.indigo[200],
                        backgroundImage:
                            _file != null ? FileImage(_file!) : null,
                        child: _file == null
                            ? Icon(
                                Icons.add_a_photo,
                                size: 40,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildTextField(
                      controller: nameController,
                      label: 'Hotel Name',
                      icon: Icons.hotel,
                    ),
                    SizedBox(height: 15),
                    _buildTextField(
                      controller: addressController,
                      label: 'Address',
                      icon: Icons.location_on,
                    ),
                    SizedBox(height: 15),
                    _buildTextField(
                      controller: phoneController,
                      label: 'Phone',
                      icon: Icons.phone,
                    ),
                    SizedBox(height: 15),
                    _buildTextField(
                      controller: emailController,
                      label: 'Email',
                      icon: Icons.email,
                    ),
                    SizedBox(height: 15),
                    _buildTextField(
                      controller: passwordController,
                      label: 'Password',
                      icon: Icons.lock,
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        Map<String, dynamic> data = {
                          "name": nameController.text,
                          "address": addressController.text,
                          "phone": phoneController.text,
                          "email": emailController.text,
                        };
                        await SampleRegister(context, emailController.text,
                            passwordController.text, data, _file);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.indigo),
        labelText: label,
        labelStyle: TextStyle(color: Colors.indigo.shade300),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.indigo.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.indigo),
        ),
      ),
    );
  }
}

final FirebaseAuth Sample_auth = FirebaseAuth.instance;
final FirebaseFirestore Sample_store = FirebaseFirestore.instance;

Future<void> SampleRegister(BuildContext context, String email, String password,
    Map<String, dynamic> data, File? _file) async {
  try {
    UserCredential cred = await Sample_auth.createUserWithEmailAndPassword(
        email: email, password: password);

    if (cred.user != null) {
      try {
        final store = FirebaseStorage.instance
            .ref()
            .child('hotel_images')
            .child('${cred.user!.uid}.jpg');
        await store.putFile(_file!);
        final imageurl = await store.getDownloadURL();
        data['imgUrl'] = imageurl;
      } catch (e) {
        print('Error uploading image: $e');
      }

      try {
        await Sample_store.collection("Hotels").doc(email).set(data);
      } catch (e) {
        print('Error saving hotel data: $e');
      }
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Hotel Registered successfully")));
    Navigator.pop(context);
    Navigator.pop(context);
  } catch (e) {
    print(e);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hotel Registration unsuccessful")));
  }
}
