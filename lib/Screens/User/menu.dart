import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mealmate/Screens/User/cart.dart';

class Menu extends StatefulWidget {
  final String restname;
  final String restaddress;
  final String restemail;

  Menu({
    super.key,
    required this.restname,
    required this.restaddress,
    required this.restemail,
  });

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  double _totalPrice = 0.0; // Total price tracker
  List<MenuItem> _menuItems = [];
  List<MenuItem> _cartItems = []; // Local cart state

  @override
  void initState() {
    super.initState();
    _fetchMenuItems(widget.restemail); // Fetch based on restaurant email
  }

  Future<void> _fetchMenuItems(String restEmail) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Dishes') // Ensure this collection exists
        .where('email', isEqualTo: restEmail) // Find restaurant by email
        .get();

    if (snapshot.docs.isNotEmpty) {
      setState(() {
        _menuItems = snapshot.docs.map((doc) {
          return MenuItem(
            name: doc['name of the dish'],
            price: (double.parse(doc['price'])),
            imageUrl: doc['imgurl'] ?? "",
          );
        }).toList();
      });
    }
  }

  void _addToCart(MenuItem item) {
    setState(() {
      if (_cartItems.contains(item)) {
        // Item already in cart, increase quantity
        _cartItems.firstWhere((cartItem) => cartItem == item).quantity++;
      } else {
        // Item not in cart, add it
        _cartItems.add(item);
      }
      _totalPrice += item.price; // Update total price
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.restname,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.restaddress,
              style: TextStyle(color: Colors.black54, fontSize: 14.0),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _menuItems.length,
                itemBuilder: (context, index) {
                  final item = _menuItems[index];
                  final isAdded = _cartItems.contains(item);
                  return MenuItemCard(
                    menuItem: item,
                    onAddToCart: _addToCart, // Pass the function directly
                    isAdded: isAdded,
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to Cart Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Cart(
                        cartitems: _cartItems,
                        totalPrice: _totalPrice,
                        restEmail: widget.restemail, restname: widget.restname, restaddress: widget.restaddress,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700, // Button color
                  padding: EdgeInsets.symmetric(vertical: 16), // Button padding
                ),
                child: Text(
                  'Go to Cart',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItemCard extends StatelessWidget {
  final MenuItem menuItem;
  final Function(MenuItem) onAddToCart;
  final bool isAdded;

  const MenuItemCard({
    Key? key,
    required this.menuItem,
    required this.onAddToCart,
    required this.isAdded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Container(
        height: 180,
        padding: EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text(
                    menuItem.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '\$${menuItem.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () {
                      onAddToCart(menuItem); // Call the function when button pressed
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700, // Button color
                    ),
                    child: Text(
                      isAdded ? "Added" : "Add to cart",
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  menuItem.imageUrl.isNotEmpty
                      ? menuItem.imageUrl
                      : "https://wallpapercave.com/wp/wp7556107.jpg", // Placeholder or actual image
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  final String name;
  final double price;
  final String imageUrl;
  int quantity;

  MenuItem({
    required this.name,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });

  // Override equality and hashCode to use contains and firstWhere correctly
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MenuItem && other.name == name && other.price == price;
  }

  @override
  int get hashCode => name.hashCode ^ price.hashCode;
}
