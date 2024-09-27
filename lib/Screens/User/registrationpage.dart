import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mealmate/Screens/login.dart';
class RegistrationPage extends StatelessWidget {
  final form_Key = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController cnfpasscontroller = TextEditingController();
  TextEditingController gendercontroller = TextEditingController();
  TextEditingController dobcontroller = TextEditingController();
  final ImagePicker reg_img = ImagePicker();
  final ValueNotifier<File?> _file = ValueNotifier<File?>(null);

  Future<void> _pickImage() async {
    final pickedFile = await reg_img.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _file.value = File(pickedFile.path);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dobcontroller.text = "${picked.year}-${picked.month}-${picked.day}";
    }
  }

  RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: form_Key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile image selection
                Stack(
                  children: [
                    ValueListenableBuilder<File?>(
                      valueListenable: _file,
                      builder: (context, file, child) {
                        return CircleAvatar(
                          radius: 50,
                          backgroundImage: file != null
                              ? FileImage(file)
                              : const AssetImage("assets/placeholder.png") as ImageProvider,
                        );
                      },
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          _pickImage();
                        },
                        child: const Icon(Icons.add_a_photo),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                // Email field
                TextFormField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.email),
                    label: const Text("Email"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // Username field
                TextFormField(
                  controller: usernamecontroller,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.person),
                    label: const Text("Username"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // Gender field
                TextFormField(
                  controller: gendercontroller,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.person_outline),
                    label: const Text("Gender"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // Date of Birth field with date picker
                TextFormField(
                  controller: dobcontroller,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.calendar_today),
                    label: const Text("Date of Birth"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                  ),
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode()); // Prevents keyboard from appearing
                    _selectDate(context);
                  },
                ),
                const SizedBox(height: 15),
                // Password field
                TextFormField(
                  controller: passcontroller,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.remove_red_eye),
                    label: const Text("Password"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 15),
                // Confirm password field
                TextFormField(
                  controller: cnfpasscontroller,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.remove_red_eye),
                    label: const Text("Confirm Password"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 15),
                // Register button
                InkWell(
                  onTap: () async {
                    if (form_Key.currentState!.validate()) {
                      Map<String, dynamic> data = {
                        "username": usernamecontroller.text,
                        "email": emailcontroller.text,
                        "gender": gendercontroller.text,
                        "date_of_birth": dobcontroller.text,
                      //  "password": passcontroller.text,
                      };
                      print(data);
                      await Register(
                        context,
                        data,
                        emailcontroller.text,
                        passcontroller.text,
                        _file.value,  // Pass the selected image file to the API
                      );
                    }
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade900,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Loginpage(),
                            ));
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}










final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore Fstore = FirebaseFirestore.instance;
final FirebaseStorage storage = FirebaseStorage.instance; 

Future<void> Register(BuildContext context, Map<String, dynamic> data, String eMail, String passWord, File? imageFile) async {
  try {

    UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: eMail, password: passWord);
        print("buq");

    String? imageUrl;
    if (imageFile != null) {
      String fileName = 'profileImages/$eMail.jpg';
      UploadTask uploadTask = storage.ref(fileName).putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
    }

    data['profileImage'] = imageUrl;
    await Fstore.collection("USers").doc(eMail).set(data);


    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("User registered successfully")));
        Navigator.pop(context);
  } catch (e) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Registration failed: ${e.toString()}")),
    );
    print(e);
  }
}

