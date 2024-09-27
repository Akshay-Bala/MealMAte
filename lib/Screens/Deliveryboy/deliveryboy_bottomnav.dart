import 'package:flutter/material.dart';
import 'package:mealmate/Screens/Deliveryboy/deliveryboy_account.dart';
import 'package:mealmate/Screens/Deliveryboy/deliveryboy_homepage.dart';
import 'package:mealmate/Screens/Deliveryboy/deliveryboy_orders.dart';



class DeliveryboyBottomnav extends StatefulWidget {
  final int? ind;

  const DeliveryboyBottomnav({super.key, this.ind});

  @override
  _BottomnaviState createState() => _BottomnaviState();
}

class _BottomnaviState extends State<DeliveryboyBottomnav> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = [
    DeliveryboyHomepage(),
    DeliveryboyOrders(),
    DeliveryboyAccount(),
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
            label: 'Dashboard',
            backgroundColor: Colors.deepOrange,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Orders',
            backgroundColor: Colors.deepOrange,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Account',
            backgroundColor: Colors.deepOrange,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
