import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[500],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[500],
        title: const Text("Profile"),
      ),
      body: Stack(
        children: [
          const Column(
            children: [],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(color: Colors.white, spreadRadius: 3),
                ],
                borderRadius: BorderRadius.vertical(
                  top: Radius.elliptical(
                    MediaQuery.of(context).size.width,
                    100.0,
                  ),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            "https://i.ytimg.com/vi/WhVDS4EARSc/hqdefault.jpg"),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      
                      decoration: InputDecoration(
                          hintText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Mobile",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Date of Birth",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Gender",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.deepOrange[500],
                        ),
                        child: const Center(
                          child: Text(
                            "Update",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}









Future<void> ProfileGet() async {
  try {
    String? email = FirebaseAuth.instance.currentUser!.email;
    print(email);
    var update = FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email);
    QuerySnapshot querySnapshot = await update.get();
    print(querySnapshot);
  List<Map<String, dynamic>>   profiledatasss =
        querySnapshot.docs.map((doc) {
      return {  
        'username': doc['username'],
        'email': doc['email'],
        'gender': doc['gender'],
        'profileImage': doc['profileImage'],
        'date_of_birth': doc['date_of_birth']
      };
    }).toList();
    print(profiledata);
    if (profiledatasss.isNotEmpty) {
      profiledata=profiledatasss[0];
    }
  } catch (e) {
    print("exptn:$e");
  }
}
Map<String, dynamic> profiledata={};
