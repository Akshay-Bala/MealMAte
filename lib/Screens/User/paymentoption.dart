import 'package:flutter/material.dart';
import 'package:mealmate/Screens/User/menu.dart'; // Ensure MenuItem is imported correctly
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealmate/Screens/login.dart';

class Payment extends StatelessWidget {
  final List<MenuItem> cart_items;
  final double billAmount;
  final String restEmail;

  Payment({super.key, required this.cart_items, required this.billAmount, required this.restEmail});

  double get deliveryCharge => 50.0;

  double get totalAmount => billAmount + deliveryCharge;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Payment Method'),
      ),
      body: Padding(
        padding:  EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Ordered Items Section
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
            
            // Bill Summary Section
            Text(
              "Bill Summary",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
             SizedBox(height: 10),

            // MRP Total
            ListTile(
              leading: Icon(Icons.attach_money_outlined, color: Colors.grey),
              title: Text("MRP Total"),
              trailing: Text("₹ ${billAmount.toStringAsFixed(2)}"),
            ),

            // Delivery Charges
            ListTile(
              leading: Icon(Icons.delivery_dining, color: Colors.grey),
              title: Text("Delivery Charges"),
              trailing: Text("₹ ${deliveryCharge.toStringAsFixed(2)}"),
            ),

            // Total Amount
            ListTile(
              leading: Icon(Icons.attach_money, color: Colors.black),
              title: Text("Total Amount",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              trailing: Text("₹ ${totalAmount.toStringAsFixed(2)}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ),

             SizedBox(height: 20),

            // Confirm Payment Button
            ElevatedButton(
              onPressed: () {
                storePaymentDetails();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Payment Confirmed!'),
                ));
              },
              child: Text("Confirm order"),
            ),
          ],
        ),
      ),
    );
  }

  void storePaymentDetails() async {
   
    String userId =  currentuserdata['email'];

    CollectionReference payments = FirebaseFirestore.instance.collection('payments');
    try {
      await payments.add({
        'user_email': userId,
        'hotel_email':restEmail,
        'items': cart_items.map((item) => {
          'name': item.name,
          'price': item.price,
          'quantity': item.quantity,
        }).toList(),
        'total': totalAmount,
        'timestamp': FieldValue.serverTimestamp(),
        'Order status': "Pending"
      });
      print('Payment details stored successfully');
    } catch (e) {
      print('Failed to store payment details: $e');
    }
  }
}
