import 'package:flutter/material.dart';
import 'package:mealmate/Screens/Hotel/Hotel_dishesadd.dart';
import 'package:mealmate/Screens/Hotel/Hotel_orderlist.dart';
import 'package:mealmate/Screens/Hotel/Hotel_viewprofile.dart';


class HotelBottomnav extends StatefulWidget {
  const HotelBottomnav({super.key});

  @override
  _BottomNavPageState createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<HotelBottomnav> {
  int _selectedIndex = 0;

  // Pages for the BottomNavigationBar
  static final List<Widget> _widgetOptions = <Widget>[
    HotelDishesadd(),
    HotelOrderlist(),
    HotelViewprofile()
    
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}
