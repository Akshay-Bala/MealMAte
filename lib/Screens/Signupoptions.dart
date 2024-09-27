import 'package:flutter/material.dart';
import 'package:mealmate/Screens/Deliveryboy/deliverysignup.dart';
import 'package:mealmate/Screens/Hotel/Hotel_signup.dart';
import 'package:mealmate/Screens/User/registrationpage.dart';


class SignupOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signup Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignupSelectionPage(),
    );
  }
}

class SignupSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Signup Options'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildSignupButton(
                  context: context,
                  title: 'Delivery Boy Signup',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Deliveryboysignup()),
                    );
                  },
                  icon: Icons.delivery_dining,
                ),
                SizedBox(height: 20), // Space between buttons
                buildSignupButton(
                  context: context,
                  title: 'User Signup',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistrationPage()),
                    );
                  },
                  icon: Icons.person,
                ),
                SizedBox(height: 20), // Space between buttons
                buildSignupButton(
                  context: context,
                  title: 'Hotel Signup',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HotelSignup()),
                    );
                  },
                  icon: Icons.hotel,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSignupButton({
    required BuildContext context,
    required String title,
    required VoidCallback onPressed,
    required IconData icon,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.blueAccent, backgroundColor: Colors.white, padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0), // Text and icon color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 5,
        side: BorderSide(color: Colors.blueAccent, width: 2),
      ),
      onPressed: onPressed,
      icon: Icon(icon, size: 24, color: Colors.blueAccent),
      label: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
