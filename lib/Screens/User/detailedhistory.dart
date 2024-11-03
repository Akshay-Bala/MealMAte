import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mealmate/Screens/login.dart';

class Myorders extends StatelessWidget {
  Myorders({super.key});

  final String userEmail = FirebaseAuth.instance.currentUser!.email!;

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
        title: Text(
          "Order Details",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('payments')
            .where('user_email', isEqualTo: userEmail)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No orders found.'));
          }

          var orders = snapshot.data!.docs;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              var orderData = orders[index].data() as Map<String, dynamic>;
              List items = orderData['items'] as List;

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 4),
                      ListTile(
                        tileColor: Colors.white,
                        leading: Icon(Icons.calendar_today_outlined, color: Colors.grey),
                        title: Text("Delivery on", style: TextStyle(color: Colors.grey)),
                        trailing: Text(
                          (orderData['timestamp'] as Timestamp).toDate().toString(),
                          style: TextStyle(fontSize: 14),
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
                            Text(currentuserdata['name']),
                          ],
                        ),
                        subtitle: Text(
                          currentuserdata['place'],
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Food Items",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (context, itemIndex) {
                            final item = items[itemIndex];
                            return ListTile(
                              title: Text(
                                item['name'] ?? 'Unknown Item', // Default name if 'name' is null
                                style: TextStyle(fontSize: 16),
                              ),
                              subtitle: Text("Qty: ${item['quantity'] ?? '0'}"), // Default quantity if null
                              trailing: Text(
                                '₹${item['price']?.toString() ?? '0.00'}', // Default price if null
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Divider(
                            height: 30,
                            thickness: 1.5,
                            color: Color.fromARGB(255, 220, 220, 220),
                            endIndent: 16,
                            indent: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.all(13.0),
                        child: Text(
                          "Payment Summary",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("MRP Total", style: TextStyle(color: Colors.grey)),
                                    Text("₹${orderData['total'].toStringAsFixed(2)}"),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Discount", style: TextStyle(color: Colors.grey)),
                                    Text("- ₹0.00"), // No discount in this example
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Shipping Fee", style: TextStyle(color: Colors.grey)),
                                    Text("+ ₹50.00"), // Assuming shipping is fixed at ₹50
                                  ],
                                ),
                                SizedBox(height: 15),
                                DottedLine(dashColor: Colors.grey),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Bill Amount", style: TextStyle(color: Colors.grey)),
                                    Text(
                                      "₹${(orderData['total'] + 50).toStringAsFixed(2)}",
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
