import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Deliveryboysignup extends StatefulWidget {
  Deliveryboysignup({super.key});

  @override
  State<Deliveryboysignup> createState() => _SampleregState();
}

class _SampleregState extends State<Deliveryboysignup> {
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
    return Form(
      child: Scaffold(
        resizeToAvoidBottomInset: true, // Allow keyboard to push content
        body: SingleChildScrollView( // Enable scrolling for the entire page
          child: Container(
            height: MediaQuery.of(context).size.height, // Ensure the container takes the full height
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.lightBlueAccent, Colors.purpleAccent.withOpacity(0.5)], // Gradient
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50), // To add spacing from top
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _file != null ? FileImage(_file!) : null,
                      child: _file == null
                          ? Icon(
                              Icons.add_a_photo,
                              size: 50,
                              color: Colors.grey[700],
                            )
                          : null,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: ageController,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: placeController,
                    decoration: InputDecoration(
                      labelText: 'Place',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true, // Ensure password is obscured
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      Map<String, dynamic> data = {
                        "name": nameController.text,
                        "age": ageController.text,
                        "place": placeController.text,
                        "email": emailController.text,
                      };
                      SampleRegister(
                        context,
                        emailController.text,
                        passwordController.text,
                        data,
                        _file,
                      );
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
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
            .child('deliveryboy_images')
            .child('${cred.user!.uid}.jpg');
        await store.putFile(_file!);
        final imageurl = await store.getDownloadURL();
        data['imgUrl'] = imageurl;
      } catch (e) {
        print('error img add $e');
      }

      try {
        await Sample_store.collection("Delivery_boys").doc(email).set(data);
      } catch (e) {
        print('error register $e');
      }
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Registered successfully")));
  } catch (e) {
    print(e);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("unsuccessful")));
  }
}
