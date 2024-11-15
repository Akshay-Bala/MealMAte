import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mealmate/Screens/User/detailedhistory.dart';
import 'package:mealmate/Screens/User/payment.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.all(10.0),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildOrderSummary(),
          Divider(height: 30, thickness: 2, color: Colors.grey.shade300),
          _buildOrderDetails(context),
          _buildActionButton(context, order),
        ]),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order Date:',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
            Text(order.date,
                style: TextStyle(color: Colors.black, fontSize: 14)),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Payment: ${order.payment}',
                style: TextStyle(color: Colors.grey, fontSize: 13)),
            Text(order.total.toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildOrderDetails(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(7),
      leading: Container(
        width: 60,
        height: 60,
        color: Colors.orange.shade100,
        child: Icon(Icons.fastfood, size: 40, color: Colors.orange),
      ),
      title: Padding(
        padding: EdgeInsets.only(bottom: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(order.restaurant, style: TextStyle(fontSize: 16)),
            Text(order.status,
                style: TextStyle(color: Colors.green, fontSize: 14)),
          ],
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Myorders(),
            ),
          );
        },
        icon: Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, Order order) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ElevatedButton(
        onPressed: () async {
          await updateOrderStatus(order);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text("Order delivered", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Future<void> updateOrderStatus(Order order) async {
    try {
      String orderId = order.id;
      DocumentReference paymentRef =
          FirebaseFirestore.instance.collection('payments').doc(orderId);

      await paymentRef.update({
        'Order status': 'Order received',
      });

      print('Order status updated to "Order received".');
    } catch (e) {
      print('Failed to update order status: $e');
    }
  }
}

class Order {
  final String id;
  final String date;
  final String restaurant;
  final List<String> items;
  final double total;
  final String status;
  final String payment;

  Order({
    required this.id,
    required this.date,
    required this.restaurant,
    required this.items,
    required this.total,
    required this.status,
    required this.payment,
  });
}

class History extends StatelessWidget {
  final String? userEmail;

  History({Key? key})
      : userEmail = FirebaseAuth.instance.currentUser?.email,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
        backgroundColor: Colors.green,
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
              List<String> itemNames = (orderData['items'] as List)
                  .map((item) => item['name'] as String)
                  .toList();

              return OrderCard(
                order: Order(
                  id: orders[index].id,
                  date:
                      (orderData['timestamp'] as Timestamp).toDate().toString(),
                  restaurant: orderData['hotel_email'],
                  items: itemNames,
                  total: orderData['total'] as double,
                  status: orderData['Order status'],
                  payment: orderData['Payment'],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
