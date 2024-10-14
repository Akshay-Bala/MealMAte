import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mealmate/Screens/User/about.dart';
import 'package:mealmate/Screens/User/rating.dart';
import 'package:mealmate/Screens/login.dart';
import 'package:mealmate/Screens/splash.dart';
import 'package:mealmate/firebase_options.dart';

void main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MealMate App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home:  Loginpage(),
      //SplashScreen(),
      routes: {
        'Login': (context) =>  Loginpage(),
        'About': (context) =>  AboutPage(),
        'Rating': (context) =>  Rating(),
      },
    );
  }
}
