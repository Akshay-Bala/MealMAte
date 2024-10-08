import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  double _totalPrice = 0.0; // Total price tracker
  List<MenuItem> _menuItems = [];

  @override
  void initState() {
    super.initState();
    _fetchMenuItems("user@example.com"); // Call with the actual email
  }

  Future<void> _fetchMenuItems(String email) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Hotels')
        .where('email', isEqualTo: email)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final restaurantId = snapshot.docs.first.id; // Get the restaurant ID

      final dishSnapshot = await FirebaseFirestore.instance
          .collection('Dishes')
          .doc(restaurantId) // Use restaurantId instead of email
          .collection('Dishes')
          .get();

      setState(() {
        _menuItems = dishSnapshot.docs.map((doc) {
          return MenuItem(
            name: doc['name of the dish'],
            price: doc['price'],
            imageUrl: doc['imgurl'],
          );
        }).toList();
      });
    }
  }

  void _updateTotalPrice(double itemPrice, bool isAdding) {
    setState(() {
      if (isAdding) {
        _totalPrice += itemPrice;
      } else {
        _totalPrice -= itemPrice;
        if (_totalPrice < 0) _totalPrice = 0; // Prevent negative values
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ // Fetch restaurants
            Text('Restuarant nme'
              ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            Text(
              ' Restuarant addresss',
              style: TextStyle(color: Colors.black54, fontSize: 14.0),
            ),
          ],
        ),
        actions: <Widget>[
          Container(
            height: 30,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.green.shade700,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "4.4",
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 16,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _menuItems.length, // Use the length of the menu items
                itemBuilder: (context, index) {
                  return MenuItemCard(
                    itemName: _menuItems[index].name,
                    itemPrice: _menuItems[index].price ,
                    itemImageUrl: _menuItems[index].imageUrl,
                    onUpdateTotal: _updateTotalPrice, // Passing the price updater
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
                    MaterialPageRoute(builder: (context) => const CartPage()),
                  );
                },
                child: Text('Go to Cart (\$${_totalPrice.toStringAsFixed(2)})'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItemCard extends StatefulWidget {
  final String itemName;
  final double itemPrice;
  final String itemImageUrl;
  final Function(double, bool) onUpdateTotal;

  const MenuItemCard({
    Key? key,
    required this.itemName,
    required this.itemPrice,
    required this.itemImageUrl,
    required this.onUpdateTotal,
  }) : super(key: key);

  @override
  _MenuItemCardState createState() => _MenuItemCardState();
}

class _MenuItemCardState extends State<MenuItemCard> {
  int _itemCount = 0;
  bool _addedToCart = false;

  void _increaseCount() {
    setState(() {
      _itemCount++;
      widget.onUpdateTotal(widget.itemPrice, true);
    });
  }

  void _decreaseCount() {
    if (_itemCount > 0) {
      setState(() {
        _itemCount--;
        widget.onUpdateTotal(widget.itemPrice, false);
      });
    }
  }

  void _addItemToCart() {
    setState(() {
      _addedToCart = true;
      _itemCount = 1; // Default count after adding to cart
      widget.onUpdateTotal(widget.itemPrice, true); // Add initial price
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        height: 180,
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    widget.itemName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Rating: 4.5', // Placeholder for dynamic rating
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '\$${widget.itemPrice.toStringAsFixed(2)}', // Display item price
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  _addedToCart
                      ? Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: _decreaseCount,
                              color: Colors.red,
                            ),
                            Text(
                              '$_itemCount',
                              style: const TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: _increaseCount,
                              color: Colors.green,
                            ),
                          ],
                        )
                      : ElevatedButton(
                          onPressed: _addItemToCart,
                          child: const Text('Add'),
                        ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.itemImageUrl,
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

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: const Center(
        child: Text(
          'This is the Cart Page where payment will be processed.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class MenuItem {
  final String name;
  final double price;
  final String imageUrl;

  MenuItem({required this.name, required this.price, required this.imageUrl});
}



