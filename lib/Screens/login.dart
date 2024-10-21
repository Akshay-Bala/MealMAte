import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mealmate/Screens/Deliveryboy/deliveryboy_bottomnav.dart';
import 'package:mealmate/Screens/Hotel/Hotel_bottomnav.dart';
import 'package:mealmate/Screens/Signupoptions.dart';
import 'package:mealmate/Screens/User/Bottomnav.dart';
import 'package:mealmate/Screens/User/forgotpassword.dart';

class Loginpage extends StatefulWidget {
   Loginpage({super.key});

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
    'Users', // Add any navigation here if Admin is supposed to go to a different page
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
              Colors.green.shade700,
              Colors.greenAccent.shade700,
              Colors.lightGreenAccent.shade100,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
               SizedBox(height: 80),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  <Widget>[
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
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
               SizedBox(height: 40),
              Container(
                decoration:  BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(55),
                    topRight: Radius.circular(55),
                  ),
                ),
                child: Padding(
                  padding:
                       EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Column(
                    children: <Widget>[
                      // Username field
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 4,
                        child: TextFormField(
                          controller: usernamectrl,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon:  Icon(Icons.email),
                          ),
                        ),
                      ),
                       SizedBox(height: 20),

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
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: Icon(Icons.visibility),
                          ),
                        ),
                      ),
                       SizedBox(height: 20),

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
                              color: Colors.black,
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
                       SizedBox(height: 30),

                      // Login button
                      ElevatedButton(
                        onPressed: () {
                          if (selectedUserType != null) {
                            login(
                                context, usernamectrl.text, passwordctrl.text);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                content: Text('Please select a user type'),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding:  EdgeInsets.symmetric(
                              vertical: 15, horizontal: 80),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 8,
                        ),
                        child:  Text(
                          'Login',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                       SizedBox(height: 10),

                      // Forgot password link
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage(),));
                          },
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                       SizedBox(height: 20),

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
                            color: Colors.green.shade700,
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
Future<void> login(
  BuildContext context,
  String email,
  String password,
) async {
  FirebaseAuth loginauth = FirebaseAuth.instance;
  try {
    UserCredential logincred = await loginauth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    String? type = await getDataTypes(email);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Login Successful as $type")),
    );

    // Navigate to respective page based on user type
    switch (type) {
      case 'Users':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  Bottomnavi()),
        );
        break;
      case 'Delivery_boys':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  DeliveryboyBottomnav()),
        );
        
        break;
      case 'Hotels':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  HotelBottomnav()),
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
           SnackBar(content: Text('Invalid user type')),
        );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Login failed: ${e.toString()}")),
    );
  }
}

Future<String?> getDataTypes(String email) async {
  final List<String> userTypes = [
    'Delivery_boys',
    'Hotels',
    'Users', // Add any navigation here if Admin is supposed to go to a different page
  ];

  try {
    for (String collection in userTypes) {
      // Log the collection being checked
      print('Checking collection: $collection');

      // Querying the collection
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection(collection)
              .where('email', isEqualTo: email)
              .get();

      // Log the number of documents returned by the query
      print('Documents found in $collection: ${querySnapshot.docs.length}');
      List<Map<String, dynamic>> userdata = [];
      // Check if any documents are returned
      if (querySnapshot.docs.isNotEmpty) {
        print('User found in $collection');

        // Get the first document
        if (collection == 'Delivery_boys') {
          userdata = querySnapshot.docs.map((doc) {
            return {
              'name': doc['name'],
              'age': doc['age'].toString(),
              'place': doc['place'],
              'email': doc['email'],
              'imgUrl': doc['imgUrl'],
            };
          }).toList();
        } else if (collection == 'Hotels') {
          userdata = querySnapshot.docs.map((doc) {
            return {
              'name': doc['name'],
              'email': doc['email'],
              'phone': doc['phone'].toString(),
              'address': doc['address'],
              // 'imgUrl': doc['imgUrl'],
            };
          }).toList();
        } else if (collection == "Users") {
          userdata = querySnapshot.docs.map((doc) {
            return {
              'name': doc['name'],
              'age': doc['age'],
              'place': doc['place'],
              'email': doc['email'],
              // 'imgUrl': doc['imgUrl'],
            };
          }).toList();
        }

        if (userdata.isNotEmpty) {
          currentuserdata = userdata.first;
        }

        return collection; // Return the collection type if user is found
      }
    }

    // If no user found in any collection, return null
    print('No user found in any collection');
    return null;
  } catch (e) {
    // Log the error if there is any issue with querying Firestore
    print('Error fetching data: $e');
    return null;
  }
}

Map<String, dynamic> currentuserdata = {};