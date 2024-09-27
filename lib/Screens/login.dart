import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mealmate/Screens/Deliveryboy/deliveryboy_bottomnav.dart';
import 'package:mealmate/Screens/Hotel/Hotel_bottomnav.dart';
import 'package:mealmate/Screens/Signupoptions.dart';
import 'package:mealmate/Screens/User/Bottomnav.dart';
import 'package:mealmate/Screens/User/forgotpassword.dart';
import 'package:mealmate/Screens/User/registrationpage.dart';


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
    'Delivery Boy',
    'User',
    'Admin',
    'Hotel',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.orange.shade900,
              Colors.orange.shade800,
              Colors.orange.shade400,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome Back",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(55),
                    topRight: Radius.circular(55),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 30),
                      Card(
                        child: TextFormField(
                          controller: usernamectrl,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            prefixIcon: const Icon(Icons.email),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Card(
                        child: TextFormField(
                          controller: passwordctrl,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: const Icon(Icons.remove_red_eye)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Dropdown for selecting user type
                      Card(
                        child: DropdownButtonFormField<String>(
                          value: selectedUserType,
                          decoration: InputDecoration(
                            labelText: 'Select User Type',
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
                      TextButton(
                        onPressed: () {
                          if (selectedUserType != null) {
                            Login(context, usernamectrl.text,
                                passwordctrl.text, selectedUserType!);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select a user type'),
                              ),
                            );
                          }
                        },
                        child: const Text('Login'),
                      ),
                      const SizedBox(height: 1),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(color: Colors.orange.shade900),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegistrationPage(),
                            ),
                          );
                        },
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignupSelectionPage(),));
                          },
                          child: Text(
                            'Create an account',
                            style: TextStyle(color: Colors.orange.shade900),
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
      ),
    );
  }
}

Future<void> Login(context, email, password, userType) async {
  FirebaseAuth loginauth = FirebaseAuth.instance;
  try {
    UserCredential logincred =
        await loginauth.signInWithEmailAndPassword(email: email, password: password);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Login Successful as $userType")),
    );

    // Navigate to respective page based on user type
    switch (userType) {
      case 'Delivery Boy':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DeliveryboyBottomnav()));
        break;
      case 'User':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Bottomnavi()));
        break;
      // case 'Admin':
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => AdminDashboard()));
      // break;
      case 'Hotel':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HotelBottomnav()));
        break;
      default:
        break;
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Login failed: $e")),
    );
  }
}
