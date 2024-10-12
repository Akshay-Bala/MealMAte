import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HotelOrderlist extends StatefulWidget {
  HotelOrderlist({super.key});

  @override
  State<HotelOrderlist> createState() => _HotelOrderlistState();
}

class _HotelOrderlistState extends State<HotelOrderlist> {
  List<Map<String, dynamic>> orders = [];

  @override
  void initState() {
    super.initState();
    getOrderedList();
  }

  Future<void> getOrderedList() async {
    try {
      var email = FirebaseAuth.instance.currentUser!.email;

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('payments')
          .where('hotel_email', isEqualTo: email)
          .get();

      // Convert the fetched documents into a list of maps (orders)
      List<Map<String, dynamic>> fetchedOrders = snapshot.docs.map((doc) {
        Map<String, dynamic> orderData = doc.data() as Map<String, dynamic>;
        orderData['orderId'] = doc.id; // Adding the document ID as orderId
        return orderData;
      }).toList();

      setState(() {
        orders = fetchedOrders;
      });
    } catch (e) {
      print('Failed to fetch orders: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text("Orders",style: TextStyle(color: Colors.white),),
       backgroundColor: Colors.deepPurple),
      body: Container(
        decoration:  BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding:  EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
               SizedBox(height: 20),
              Expanded(
                child: orders.isEmpty
                    ?  Center(
                        child: Text(
                          'No orders found.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final order = orders[index];
                          return OrderCard(order: order);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;

   OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin:  EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order ID and Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order ID: ${order['orderId']}',
                  style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.deepPurple,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(width: 10,),
                Text(
                  (order['timestamp'] as Timestamp).toDate().toString(),
                  style:  TextStyle(color: Colors.grey),
                ),
              ],
            ),
             SizedBox(height: 10),

            // Amount and Payment Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Amount: ₹${order['total'].toStringAsFixed(2)}',
                    style:  TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                OrderStatusBadge(status: 'Completed'), // Update status as needed
              ],
            ),
             SizedBox(height: 10),

            // Payment status and icon
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
                 SizedBox(width: 10),
                 Text(
                  'Completed',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OrderStatusBadge extends StatelessWidget {
  final String status;

   OrderStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color statusColor = Colors.green;

    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: statusColor,
        ),
      ),
    );
  }
}
