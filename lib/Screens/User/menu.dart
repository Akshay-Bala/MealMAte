import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name of the Restaurant",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Address of Restaurant",
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                itemCount: 10, // Limit the number of items to 10
                shrinkWrap: true, // Prevent overflow
                physics: const NeverScrollableScrollPhysics(), // Disable scrolling
                itemBuilder: (context, index) {
                  return MenuItemCard(
                    itemName: 'Item Name $index',
                    itemPrice: 12.99 + index,
                    itemImageUrl: "https://wallpapercave.com/wp/wp8847780.jpg",
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItemCard extends StatefulWidget {
  final String itemName;
  final double itemPrice;
  final String itemImageUrl;

  const MenuItemCard({
    Key? key,
    required this.itemName,
    required this.itemPrice,
    required this.itemImageUrl,
  }) : super(key: key);

  @override
  _MenuItemCardState createState() => _MenuItemCardState();
}

class _MenuItemCardState extends State<MenuItemCard> {
  int _itemCount = 0;

  void _increaseCount() {
    setState(() {
      _itemCount++;
    });
  }

  void _decreaseCount() {
    setState(() {
      if (_itemCount > 0) {
        _itemCount--;
      }
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
                  Row(
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
