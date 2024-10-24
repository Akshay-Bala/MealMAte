import 'package:flutter/material.dart';

class Deliveryboyforgotpass extends StatelessWidget {
    Deliveryboyforgotpass({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          // Background image or color
          Container(
            decoration:  BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.jpg"), // Add your background image here
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Login form
          Center(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title Text
                  Text(
                    "Meal Mate",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade900,
                      letterSpacing: 2.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                   SizedBox(height: 20),
                  
                  // Subtitle
                   Text(
                    "Forgot your Password",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                   SizedBox(height: 20),
                    Text(
                    "Don't worry we will help you.Please enter your email to reset password",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                   SizedBox(height: 40),

                  // Email TextField
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter your email id',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                   SizedBox(height: 20),

                  

                  // Login Button
                  ElevatedButton(
                    onPressed: () {
                      // Add your login logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade900,
                      padding:  EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child:  Text(
                      'Submit',
                      style: TextStyle(fontSize: 18,color: Colors.black),
                    ),
                  ),
                  
                   SizedBox(height: 10),
                  
                  
                  
                  // Sign Up Text
                 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

