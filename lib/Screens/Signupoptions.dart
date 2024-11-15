import 'package:flutter/material.dart';
import 'package:mealmate/Screens/Hotel/Hotel_signup.dart';
import 'package:mealmate/Screens/User/registrationpage.dart';


class SignupSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'Choose Signup Option',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green,
              Colors.purple,
              Colors.blue
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding:  EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                 SizedBox(height: 20),
                buildSignupButton(
                  context: context,
                  title: 'User Signup',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserRegistration()),
                    );
                  },
                  icon: Icons.person,
                ),
                 SizedBox(height: 20),
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
        backgroundColor: Colors.white,
        padding:  EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 8,
        side:  BorderSide(color: Colors.white, width: 2),
      ),
      onPressed: onPressed,
      icon: Icon(icon, size: 24, color: Colors.black),
      label: Text(
        title,
        style:  TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
