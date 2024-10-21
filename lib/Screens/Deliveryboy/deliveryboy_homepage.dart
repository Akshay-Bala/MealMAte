import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DeliveryboyHomepage extends StatefulWidget {
  DeliveryboyHomepage({super.key});

  @override
  _DeliveryboyHomepageState createState() => _DeliveryboyHomepageState();
}

class _DeliveryboyHomepageState extends State<DeliveryboyHomepage> {
  List<Map<String, dynamic>> acceptedOrders = [];

  @override
  void initState() {
    super.initState();
    getAcceptedOrders();
  }

  Future<void> getAcceptedOrders() async {
    acceptedOrders = await fetchAcceptedOrders();
    setState(() {});
  }

  Future<List<Map<String, dynamic>>> fetchAcceptedOrders() async {
    try {
      var email = FirebaseAuth.instance.currentUser!.email;

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('payments')
          .where('Order status', whereIn: ['Order accepted', 'Order confirmed by hotel and delivery_partner'])
          .get();

      List<Map<String, dynamic>> acceptedOrders = snapshot.docs.map((doc) {
        Map<String, dynamic> orderData = doc.data() as Map<String, dynamic>;
        orderData['orderId'] = doc.id;
        return orderData;
      }).toList();

      return acceptedOrders;
    } catch (e) {
      print('Failed to fetch accepted orders: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.lightBlueAccent,
        actions: [
          Icon(Icons.bike_scooter, color: Colors.white),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: acceptedOrders.isNotEmpty
            ? ListView.builder(
                itemCount: acceptedOrders.length,
                itemBuilder: (context, index) {
                  return _buildNewOrderCard(acceptedOrders[index]);
                },
              )
            : Center(child: Text('No new accepted orders.', style: TextStyle(fontSize: 16))),
      ),
    );
  }

  Widget _buildNewOrderCard(Map<String, dynamic> order) {
    List<dynamic> dishes = order['items'] ?? [];
    String userEmail = order['user_email'] ?? '';

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder<Map<String, dynamic>>(
          future: fetchUserDetails(userEmail),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error fetching user details');
            } else if (!snapshot.hasData) {
              return Text('User not found');
            }

            Map<String, dynamic> userData = snapshot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "New Order",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Order ID: ${order['orderId']}",
                  style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Customer name:  ${userData['name'] ?? ''}",
                  style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Address:  ${userData['place'] ?? ''}",
                  style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Amount: ₹${order['total'].toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Ordered Dishes:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ...dishes.map((dish) => Text("${dish['name']} - Qty: ${dish['quantity']}")),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: (order['Order status'] == 'Order confirmed by hotel and delivery_partner')
                          ? () async {
                              await deliverOrder(order['orderId']);
                              setState(() {
                                order['Order status'] = 'Order delivered successfully';
                              });
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text("Delivered", style: TextStyle(color: Colors.black)),
                    ),
                    if (order['Order status'] != 'Order confirmed by hotel and delivery_partner' &&
                        order['Order status'] != 'Order delivered successfully')
                      ElevatedButton(
                        onPressed: () async {
                          await acceptOrder(order['orderId']);
                          setState(() {
                            order['Order status'] = 'Order confirmed by hotel and delivery_partner';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text("Accept", style: TextStyle(color: Colors.black)),
                      ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> fetchUserDetails(String userEmail) async {
    try {
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('email', isEqualTo: userEmail)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        return userSnapshot.docs.first.data() as Map<String, dynamic>;
      } else {
        return {};
      }
    } catch (e) {
      print('Error fetching user details: $e');
      return {};
    }
  }
}

Future<void> acceptOrder(String orderId) async {
  try {
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      DocumentReference paymentRef = FirebaseFirestore.instance.collection('payments').doc(orderId);

      await paymentRef.update({
        'delivery_boy_id': FirebaseAuth.instance.currentUser?.email,
        'Order status': 'Order confirmed by hotel and delivery_partner',
      });

      print('Order accepted and delivery_boy_id updated.');
    } else {
      print('Failed to accept order: User not authenticated.');
    }
  } catch (e) {
    print('Failed to accept order: $e');
  }
}

Future<void> deliverOrder(String orderId) async {
  try {
    DocumentReference paymentRef = FirebaseFirestore.instance.collection('payments').doc(orderId);

    await paymentRef.update({
      'Order status': 'Order delivered successfully',
    });

    print('Order status updated to "Order delivered successfully".');
  } catch (e) {
    print('Failed to update order status: $e');
  }
}
