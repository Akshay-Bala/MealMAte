import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  File? _file;
  Map<String, dynamic>? currentuserdata;
  bool _isEditing = false; // Track whether the profile is in editing mode

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot = await _store.collection("Users").doc(user.email).get();
      setState(() {
        currentuserdata = snapshot.data() as Map<String, dynamic>;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _file = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      Map<String, dynamic> data = {
        "name": currentuserdata?['name'],
        "place": currentuserdata?['place'],
        "email": currentuserdata?['email'],
        "age": currentuserdata?['age'].toString(),
      };

      if (_file != null) {
        // Upload new image
        try {
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('user_images')
              .child('${user.uid}.jpg');
          await storageRef.putFile(_file!);
          final imageUrl = await storageRef.getDownloadURL();
          data['imgUrl'] = imageUrl;
        } catch (e) {
          print('Error uploading image: $e');
        }
      }

      // Update Firestore data
      try {
        await _store.collection("Users").doc(user.email).update(data);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile updated successfully")));
      } catch (e) {
        print('Error updating user data: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentuserdata == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Profile"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(color: Colors.white, blurRadius: 10, offset: Offset(0, 5)),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: _isEditing ? _pickImage : null, // Allow image picking only when editing
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: currentuserdata!['imgUrl'] != null
                        ? NetworkImage(currentuserdata!['imgUrl'])
                        : null,
                    child: currentuserdata!['imgUrl'] == null
                        ? Icon(Icons.person, size: 60, color: Colors.grey)
                        : null,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  currentuserdata!['name'],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green[700]),
                ),
                SizedBox(height: 10),
                buildInfoField("Location", currentuserdata!['place']),
                buildInfoField("Email", currentuserdata!['email']),
                buildInfoField("Age", currentuserdata!['age'].toString()),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isEditing ? _updateProfile : null, // Update button is only enabled during editing
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Update",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isEditing = !_isEditing; // Toggle edit mode
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _isEditing ? "Cancel Edit" : "Edit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoField(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.green[700]),
          ),
          SizedBox(height: 5),
          TextFormField(
            initialValue: value,
            readOnly: !_isEditing, // Enable editing only if _isEditing is true
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.green, width: 1),
              ),
            ),
            onChanged: (newValue) {
              setState(() {
                if (label == "Location") {
                  currentuserdata!['place'] = newValue;
                } else if (label == "Email") {
                  currentuserdata!['email'] = newValue;
                } else if (label == "Age") {
                  currentuserdata!['age'] = newValue;
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
