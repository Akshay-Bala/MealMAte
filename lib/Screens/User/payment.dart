import 'package:flutter/material.dart';
import 'package:mealmate/Screens/User/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealmate/Screens/User/paymentoptions.dart';
import 'package:mealmate/Screens/login.dart';

class Payment extends StatelessWidget {
  final List<MenuItem> cart_items;
  final double billAmount;
  final String restEmail;

  Payment(
      {super.key,
      required this.cart_items,
      required this.billAmount,
      required this.restEmail});

  double get deliveryCharge => 50.0;

  double get totalAmount => billAmount + deliveryCharge;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Payment'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Ordered Items:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              flex: 2,
              child: ListView.builder(
                itemCount: cart_items.length,
                itemBuilder: (context, index) {
                  final item = cart_items[index];
                  double itemTotalPrice = item.price * item.quantity;
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('₹ ${item.price.toStringAsFixed(2)} each'),
                        Text('Total: ₹ ${itemTotalPrice.toStringAsFixed(2)}'),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Bill Summary",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.attach_money_outlined, color: Colors.grey),
              title: Text("MRP Total"),
              trailing: Text("₹ ${billAmount.toStringAsFixed(2)}"),
            ),
            ListTile(
              leading: Icon(Icons.delivery_dining, color: Colors.grey),
              title: Text("Delivery Charges"),
              trailing: Text("₹ ${deliveryCharge.toStringAsFixed(2)}"),
            ),
            ListTile(
              leading: Icon(Icons.attach_money, color: Colors.black),
              title: Text(
                "Total Amount",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              trailing: Text(
                "₹ ${totalAmount.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentOptions(
                        cart_items: cart_items,
                        totalAmount: totalAmount,
                        restEmail: restEmail,
                      ),
                    ));
              },
              child: Text("Pay through online"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                storePaymentDetails();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Cash on Delivery Confirmed!'),
                ));
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text("Cash on Delivery"),
            ),
          ],
        ),
      ),
    );
  }

  void storePaymentDetails() async {
    String userId = currentuserdata['email'];

    CollectionReference payments =
        FirebaseFirestore.instance.collection('payments');
    try {
      await payments.add({
        'user_email': userId,
        'hotel_email': restEmail,
        'items': cart_items
            .map((item) => {
                  'name': item.name,
                  'price': item.price,
                  'quantity': item.quantity,
                })
            .toList(),
        'total': totalAmount,
        'timestamp': FieldValue.serverTimestamp(),
        'Order status': "Pending",
        'Payment': "COD"
      });
      print('Payment details stored successfully');
    } catch (e) {
      print('Failed to store payment details: $e');
    }
  }
}
