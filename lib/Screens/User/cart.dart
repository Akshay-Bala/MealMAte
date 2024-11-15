import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:mealmate/Screens/User/menu.dart';
import 'package:mealmate/Screens/User/payment.dart';

class Cart extends StatefulWidget {
  final double totalPrice;
  final List<MenuItem> cartitems;
  final String restEmail;
  final String restname;
  final String restaddress;

  Cart(
      {super.key,
      required this.totalPrice,
      required this.cartitems,
      required this.restEmail,
      required this.restname,
      required this.restaddress});

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
        widget.cartitems.remove(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(242, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: 4),
          ListTile(
            tileColor: Colors.white,
            leading: Icon(Icons.calendar_today_outlined, color: Colors.grey),
            title: Text(
              "Delivery by",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          SizedBox(height: 4),
          ListTile(
            tileColor: Colors.white,
            leading: Icon(Icons.home_outlined, color: Colors.grey, size: 30),
            title: Row(
              children: [
                Text("Deliver to", style: TextStyle(color: Colors.grey)),
                SizedBox(width: 7),
                Text(currentuserdata!['place']),
              ],
            ),
            subtitle: Text(
              currentuserdata['place'],
              style: TextStyle(color: Colors.grey),
            ),
          ),
          SizedBox(height: 5),
          ...widget.cartitems.map((item) {
            double itemTotalPrice = item.price * item.quantity;
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              child: ListTile(
                title: Text(item.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("\₹ ${item.price.toStringAsFixed(2)} each"),
                    Text("Total: \₹ ${itemTotalPrice.toStringAsFixed(2)}"),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => _updateQuantity(item, -1),
                    ),
                    Text(item.quantity.toString()),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => _updateQuantity(item, 1),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          SizedBox(height: 5),
          SizedBox(
            height: 10,
          ),
          ListTile(
            tileColor: Colors.white,
            leading: Icon(
              Icons.attach_money_outlined,
              color: Colors.grey,
              size: 30,
            ),
            title: Text(
              "MRP Total",
              style: TextStyle(color: Colors.grey),
            ),
            trailing: Text("\₹ ${mrpTotal.toStringAsFixed(2)}"),
          ),
          SizedBox(height: 8),
          ListTile(
            tileColor: Colors.white,
            leading: Icon(Icons.delivery_dining, color: Colors.grey),
            title: Text("Delivery Charges"),
            trailing: Text("\₹ 50"),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Amount"),
                Text("\₹ ${(mrpTotal + 50).toStringAsFixed(2)}"),
              ],
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Payment(
                          billAmount: mrpTotal + 50,
                          cart_items: widget.cartitems,
                          restEmail: widget.restEmail),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  'Proceed to Payment',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
