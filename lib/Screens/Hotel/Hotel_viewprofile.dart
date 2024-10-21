import 'package:flutter/material.dart';
import 'package:mealmate/Screens/Deliveryboy/deliverysignup.dart';
import 'package:mealmate/Screens/login.dart'; // Adjust the import according to your project structure

class HotelViewprofile extends StatefulWidget {
   HotelViewprofile({super.key});

  @override
  _HotelProfilePageState createState() => _HotelProfilePageState();
}

class _HotelProfilePageState extends State<HotelViewprofile> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:  BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(
                    currentuserdata['name'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                   SizedBox(height: 30),

                  // Email Field
                  TextFormField(
                    readOnly: true,
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: currentuserdata['email'],
                      labelStyle:  TextStyle(color: Colors.white),
                      hintStyle:  TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon:  Icon(Icons.email, color: Colors.white),
                    ),
                    style:  TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                  ),
                   SizedBox(height: 20),

                  // Phone Number Field
                  TextFormField(
                    readOnly: true,
                    controller: _phoneController,
                    decoration: InputDecoration(
                      hintText: currentuserdata['phone'],
                      labelStyle:  TextStyle(color: Colors.white),
                      hintStyle:  TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon:  Icon(Icons.phone, color: Colors.white),
                    ),
                    style:  TextStyle(color: Colors.white),
                    keyboardType: TextInputType.phone,
                  ),
                   SizedBox(height: 20),

                  // Address Field
                  TextFormField(
                    readOnly: true,
                    controller: _addressController,
                    decoration: InputDecoration(
                      hintText: currentuserdata['address'],
                      labelStyle:  TextStyle(color: Colors.white),
                      hintStyle:  TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon:  Icon(Icons.location_on, color: Colors.white),
                    ),
                    style:  TextStyle(color: Colors.white),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                   SizedBox(height: 30),

                  // Add Delivery Boy Button
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the Add Delivery Boy screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Deliveryboysignup(), // Create this screen
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.deepPurple,
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Add Delivery Boy',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                   SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
