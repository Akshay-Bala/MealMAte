import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HotelOrderlist extends StatefulWidget {

   HotelOrderlist({super.key});
   
  @override
  State<HotelOrderlist> createState() => _HotelOrderlistState();
}

class _HotelOrderlistState extends State<HotelOrderlist> {@override
  void initState() {
    getorderedlist();
    super.initState();
  }
  // Dummy data representing user orders
  final List<Map<String, dynamic>> orders = [
    {
      'orderId': 'ORD12345',
      'status': 'Paid',
      'amount': 25.99,
      'date': '2023-09-12',
      'paymentStatus': 'Completed'
    },
    {
      'orderId': 'ORD67890',
      'status': 'Pending',
      'amount': 45.50,
      'date': '2023-09-10',
      'paymentStatus': 'Awaiting Payment'
    },
    {
      'orderId': 'ORD54321',
      'status': 'Paid',
      'amount': 75.99,
      'date': '2023-09-05',
      'paymentStatus': 'Completed'
    },
    {
      'orderId': 'ORD09876',
      'status': 'Cancelled',
      'amount': 100.00,
      'date': '2023-09-01',
      'paymentStatus': 'Refunded'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Orders',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
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

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order ID and Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order ID: ${order['orderId']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.deepPurple,
                  ),
                ),
                Text(
                  order['date'],
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Amount and Payment Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Amount: \$${order['amount'].toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                OrderStatusBadge(status: order['paymentStatus']),
              ],
            ),
            const SizedBox(height: 10),

            // Payment status and icon
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  order['paymentStatus'] == 'Completed'
                      ? Icons.check_circle
                      : order['paymentStatus'] == 'Awaiting Payment'
                          ? Icons.hourglass_bottom
                          : Icons.cancel,
                  color: order['paymentStatus'] == 'Completed'
                      ? Colors.green
                      : order['paymentStatus'] == 'Awaiting Payment'
                          ? Colors.orange
                          : Colors.red,
                ),
                const SizedBox(width: 10),
                Text(
                  order['paymentStatus'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: order['paymentStatus'] == 'Completed'
                        ? Colors.green
                        : order['paymentStatus'] == 'Awaiting Payment'
                            ? Colors.orange
                            : Colors.red,
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

  const OrderStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    if (status == 'Completed') {
      statusColor = Colors.green;
    } else if (status == 'Awaiting Payment') {
      statusColor = Colors.orange;
    } else if (status == 'Refunded') {
      statusColor = Colors.red;
    } else {
      statusColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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

Future<List<Map<String, dynamic>>> getorderedlist() async {
  var email=FirebaseAuth.instance.currentUser!.email;
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('payments').where('hotel_email', isEqualTo: email).get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }