import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserRegistration extends StatefulWidget {
  UserRegistration({super.key});

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController placeController = TextEditingController();
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
              colors: [Colors.green.shade800, Colors.green.shade200],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Padding(
              padding:  EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Join us and get started!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white,
                      backgroundImage: _file != null ? FileImage(_file!) : null,
                      child: _file == null
                          ? Icon(Icons.add_a_photo, size: 35, color: Colors.green)
                          : null,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    controller: nameController,
                    label: 'Full Name',
                    icon: Icons.person,
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    controller: ageController,
                    label: 'Age',
                    icon: Icons.calendar_today,
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    controller: placeController,
                    label: 'Place',
                    icon: Icons.location_on,
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    controller: emailController,
                    label: 'Email',
                    icon: Icons.email,
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    controller: passwordController,
                    label: 'Password',
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      Map<String, dynamic> data = {
                        "name": nameController.text,
                        "age": ageController.text,
                        "place": placeController.text,
                        "email": emailController.text,
                      };
                      await SampleRegister(
                        context,
                        emailController.text,
                        passwordController.text,
                        data,
                        _file,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 8,
                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ],
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
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.green),
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        contentPadding: EdgeInsets.symmetric(vertical: 18),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.blue.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
      ),
    );
  }
}

final FirebaseAuth Sample_auth = FirebaseAuth.instance;
final FirebaseFirestore Sample_store = FirebaseFirestore.instance;

Future<void> SampleRegister(
    BuildContext context, String email, String password, Map<String, dynamic> data, File? _file) async {
  try {
    UserCredential cred = await Sample_auth.createUserWithEmailAndPassword(
        email: email, password: password);

    if (cred.user != null) {
      try {
        final store = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${cred.user!.uid}.jpg');
        await store.putFile(_file!);
        final imageurl = await store.getDownloadURL();
        data['imgUrl'] = imageurl;
      } catch (e) {
        print('Error uploading image: $e');
      }

      try {
        await Sample_store.collection("Users").doc(email).set(data);
      } catch (e) {
        print('Error saving user data: $e');
      }
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("User Registered successfully")));
        Navigator.pop(context);  
        Navigator.pop(context);
  } catch (e) {
    print(e);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Registration unsuccessful")));
  }
}
