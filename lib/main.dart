import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mealmate/Screens/User/about.dart';
import 'package:mealmate/Screens/User/menu.dart';
import 'package:mealmate/Screens/User/paymentoption.dart';
import 'package:mealmate/Screens/User/rating.dart';
import 'package:mealmate/Screens/login.dart';
import 'package:mealmate/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MealMate App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const Loginpage(),
      routes: {
        'Login': (context) =>  Loginpage(),
        'About': (context) =>  AboutPage(),
        'Rating': (context) =>  Rating(),
      },
    );
  }
}
