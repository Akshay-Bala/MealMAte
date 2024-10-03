import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:mealmate/Screens/Deliveryboy/deliveryboy_bottomnav.dart';
import 'package:mealmate/Screens/Hotel/Hotel_bottomnav.dart';
import 'package:mealmate/Screens/Signupoptions.dart';
import 'package:mealmate/Screens/User/Bottomnav.dart';


class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController usernamectrl = TextEditingController();
  TextEditingController passwordctrl = TextEditingController();

  String? selectedUserType;

  final List<String> userTypes = [
    'Delivery_boys',
    'Hotels',
    'Users',  // Add any navigation here if Admin is supposed to go to a different page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade700,
              Colors.purple.shade500,
              Colors.purpleAccent.shade100,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(55),
                    topRight: Radius.circular(55),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  child: Column(
                    children: <Widget>[
                      // Username field
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 4,
                        child: TextFormField(
                          controller: usernamectrl,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Colors.purple.shade700,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.email),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Password field
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 4,
                        child: TextFormField(
                          controller: passwordctrl,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: Colors.purple.shade700,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: const Icon(Icons.visibility),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Dropdown for selecting user type
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 4,
                        child: DropdownButtonFormField<String>(
                          value: selectedUserType,
                          decoration: InputDecoration(
                            labelText: 'Select Type',
                            labelStyle: TextStyle(
                              color: Colors.purple.shade700,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          items: userTypes
                              .map(
                                (type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(type),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedUserType = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Login button
                      ElevatedButton(
                        onPressed: () {
                          if (selectedUserType != null) {
                            login(context, usernamectrl.text, passwordctrl.text);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select a user type'),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 8,
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Forgot password link
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => ForgotPasswordPage()),
                            // );
                          },
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                              color: Colors.deepPurple.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Signup link
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupSelectionPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Create an account',
                          style: TextStyle(
                            color: Colors.deepPurple.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Updated login logic to navigate based on user type
Future<void> login(BuildContext context, String email, String password,
  ) async {
  FirebaseAuth loginauth = FirebaseAuth.instance;
  try {
    UserCredential logincred = await loginauth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    String? type= await getDataTypes(email);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Login Successful as $type")),
    );

    // Navigate to respective page based on user type
    switch (type) {
      case 'Delivery_boys':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DeliveryboyBottomnav()),
        );
        break;
      case 'Users':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Bottomnavi()),
        );
        break;
      case 'Hotels':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HotelBottomnav()),
        );
        break;
      // case 'Admin':
      //   // Placeholder for Admin navigation
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Admin login successful')),
      //   );
      //   break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid user type')),
        );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Login failed: ${e.toString()}")),
    );
  }
}





Future<String?> getDataTypes( String email) async {
  final List<String> userTypes = [
    'Delivery_boys',
    'Hotels',
    'Users',  // Add any navigation here if Admin is supposed to go to a different page
  ];

  try {
    for(String collection in userTypes){
    // Querying the collection

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection(collection)
        .where('email', isEqualTo: email)
        .get();

    // Check if any documents are returned
    if (querySnapshot.docs.isNotEmpty) {
      print('User found in $collection');
      
      // Get the first document
      Map<String, dynamic>? userData = querySnapshot.docs.first.data();
      
      if (userData != null) {
        currentuserdata = userData;
        print(currentuserdata);
      }
      
      return collection;
    
    }
     else {
      print('No user found in $collection');
      return null;
    }
  }} catch (e) {
    print('Error fetching data: $e');
    return null;
  }
}

Map<String, dynamic> currentuserdata = {};


