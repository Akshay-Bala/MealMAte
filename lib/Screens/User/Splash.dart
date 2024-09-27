import 'package:flutter/material.dart';
import 'package:mealmate/Screens/login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Splashdelay();
    super.initState();
  }

  void Splashdelay() async {
    await Future.delayed(const Duration(seconds: 3));
    // TODO: implement initState
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Loginpage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "",
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
    );
  }
}
