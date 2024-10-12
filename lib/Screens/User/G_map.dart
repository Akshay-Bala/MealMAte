import 'package:flutter/material.dart';

class Gmaplocation extends StatelessWidget {
   Gmaplocation({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
       title: Text('G Map',style: TextStyle(color: Colors.white),),
       backgroundColor: Colors.green,
      ),
    );
  }
}