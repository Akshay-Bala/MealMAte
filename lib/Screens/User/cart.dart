import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:mealmate/Screens/User/menu.dart';
import 'package:mealmate/Screens/User/paymentoption.dart';

class Cart extends StatefulWidget {
  final double totalPrice;
  final List<MenuItem> cartitems;
  final String restEmail;
  final String restname;
  final String restaddress;

  Cart({super.key, required this.totalPrice, required this.cartitems, required this.restEmail, required this.restname, required this.restaddress});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  Map<String, dynamic> currentuserdata = {'place': 'Home'};

  double get mrpTotal {
    double total = 0.0;
    for (var item in widget.cartitems) {
      total += item.price * item.quantity;
    }
    return total;
  }

  void _updateQuantity(MenuItem item, int change) {
    setState(() {
      item.quantity += change;
      if (item.quantity <= 0) {
        widget.cartitems.remove(item); // Remove item if quantity is zero
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(242, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: const Text(
          "Order ID: 22261052067",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 4),
          const ListTile(
            tileColor: Colors.white,
            leading: Icon(Icons.calendar_today_outlined, color: Colors.grey),
            title: Text(
              "Delivery by",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 4),
          ListTile(
            tileColor: Colors.white,
            leading: Icon(Icons.home_outlined, color: Colors.grey, size: 30),
            title: Row(
              children: [
                Text("Deliver to", style: TextStyle(color: Colors.grey)),
                SizedBox(width: 7),
                Text("Home"),
              ],
            ),
            subtitle: Text(
              currentuserdata['place'],
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 5),
          ListTile(
            tileColor: Colors.white,
            leading: Icon(Icons.attach_money_outlined, color: Colors.grey, size: 30),
            title: Row(
              children: [
                Text("MRP Total", style: TextStyle(color: Colors.grey)),
                SizedBox(width: 7),
                Text("\$${mrpTotal.toStringAsFixed(2)}"),
              ],
            ),
          ),
          const SizedBox(height: 5),
          
          // Cart Items List
          ...widget.cartitems.map((item) {
            double itemTotalPrice = item.price * item.quantity; // Calculate total price for the item
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              child: ListTile(
                title: Text(item.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("\$${item.price.toStringAsFixed(2)} each"), // Price per item
                    Text("Total: \$${itemTotalPrice.toStringAsFixed(2)}"), // Total price for this item
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => _updateQuantity(item, -1),
                    ),
                    Text(item.quantity.toString()), // Display quantity
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => _updateQuantity(item, 1),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),

          const SizedBox(height: 8),
          
          // Delivery Charges
          const ListTile(
            tileColor: Colors.white,
            leading: Icon(Icons.delivery_dining, color: Colors.grey),
            title: Text("Delivery Charges"),
            trailing: Text("\$50"),
          ),

          // Total Amount
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Amount"),
                Text("\$${(mrpTotal + 50).toStringAsFixed(2)}"), // Total with delivery
              ],
            ),
          ),
          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to Payment Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Payment(
                        billAmount: mrpTotal + 50, // Pass the total amount including delivery charges
                        cart_items: widget.cartitems,
                        restEmail: widget.restEmail
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Proceed to Payment',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
