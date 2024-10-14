// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:mealmate/Screens/login.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   int currentIndex = 0; // To keep track of the current image index
//   final List<String> splashImages = [
//     'Splashscreen1.png', // First image
//     'FreshFood.png', // Second image
//   ];

//   @override
//   void initState() {
//     super.initState();

//     // Switch images every 2 seconds, then navigate to LoginPage
//     Timer.periodic(Duration(seconds: 2), (Timer timer) {
//       if (currentIndex < splashImages.length - 1) {
//         setState(() {
//           currentIndex++; // Move to next image
//         });
//       } else {
//         timer.cancel(); // Cancel the timer after the last image
//         navigateToLogin();
//       }
//     });
//   }

//   void navigateToLogin() {
//     // Navigate to the login page after splash screens
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => Loginpage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Image.asset(
//           splashImages[currentIndex], // Show the current image
//           fit: BoxFit.cover,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//       ),
//     );
//   }
// }
