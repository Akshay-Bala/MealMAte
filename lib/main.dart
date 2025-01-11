import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mealmate/Screens/User/about.dart';
import 'package:mealmate/Screens/User/rating.dart';
import 'package:mealmate/Screens/login.dart';
import 'package:mealmate/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MealMate App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: SplashScreenWithDelay(),
      routes: {
        'About': (context) => AboutPage(),
        'Rating': (context) => Rating(),
        'Login': (context) => Loginpage(),
      },
    );
  }
}

class SplashScreenWithDelay extends StatefulWidget {
  @override
  State<SplashScreenWithDelay> createState() => _SplashScreenWithDelayState();
}

class _SplashScreenWithDelayState extends State<SplashScreenWithDelay> {
  @override
  void initState() {
    super.initState();
    // Remove native splash screen
    FlutterNativeSplash.remove();

    // Navigate to the Login screen after 5 seconds
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, 'Login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/pictures/Splashscreen1.png',
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
