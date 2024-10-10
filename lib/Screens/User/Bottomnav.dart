import 'package:flutter/material.dart';
import 'package:mealmate/Screens/User/G_map.dart';
import 'package:mealmate/Screens/User/Profileall.dart';
import 'package:mealmate/Screens/User/cart.dart';

import 'package:mealmate/Screens/User/delivery.dart';
import 'package:mealmate/Screens/User/history.dart';

class Bottomnavi extends StatefulWidget {
  final int? ind;

  const Bottomnavi({super.key, this.ind});

  @override
  _BottomnaviState createState() => _BottomnaviState();
}

class _BottomnaviState extends State<Bottomnavi> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = [
    Delivery(),
    Gmaplocation(),
    History(),
     Profileall(),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.ind != null) {
      _selectedIndex = widget.ind!;
      _pageController.jumpToPage(_selectedIndex);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.delivery_dining),
            label: 'Delivery',
            backgroundColor: Colors.redAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            label: 'Location',
            backgroundColor: Colors.redAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
            backgroundColor: Colors.redAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
            backgroundColor: Colors.redAccent,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
