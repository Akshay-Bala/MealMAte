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

      List<Map<String, dynamic>> fetchedOrders = snapshot.docs.map((doc) {
        Map<String, dynamic> orderData = doc.data() as Map<String, dynamic>;
        orderData['orderId'] = doc.id;
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
      appBar: AppBar(
          title: Text(
            "Orders",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.indigo),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo, Colors.indigoAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Expanded(
                child: orders.isEmpty
                    ? Center(
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
                          return OrderCard(
                            order: order,
                            onStatusChange: getOrderedList,
                          );
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

class OrderCard extends StatefulWidget {
  final Map<String, dynamic> order;
  final Function onStatusChange;

  OrderCard({super.key, required this.order, required this.onStatusChange});

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  late bool isAccepted;
  late bool isRejected;

  @override
  void initState() {
    super.initState();
    isAccepted = widget.order['Order status'] == 'Order accepted';
    isRejected = widget.order['Order status'] == 'Order rejected';
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    try {
      await FirebaseFirestore.instance
          .collection('payments')
          .doc(orderId)
          .update({
        'Order status': newStatus,
      });
      print('Order status updated to: $newStatus');
      setState(() {
        if (newStatus == 'Order accepted') {
          isAccepted = true;
          isRejected = false;
        } else if (newStatus == 'Order rejected') {
          isRejected = true;
          isAccepted = false;
        }
      });
    } catch (e) {
      print('Failed to update order status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> dishes = widget.order['items'] ?? [];

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Order ID: ${widget.order['orderId']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.deepPurple,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  (widget.order['timestamp'] as Timestamp).toDate().toString(),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Amount: ₹${widget.order['total'].toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Payment: ${widget.order['Payment']}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Ordered Dishes:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.deepPurple,
              ),
            ),
            Container(
              height: dishes.length * 50,
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: dishes.length,
                itemBuilder: (context, index) {
                  final dish = dishes[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          dish['name'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          'Qty: ${dish['quantity'] ?? 1}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
                SizedBox(width: 10),
                Text(
                  widget.order['Order status'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (!isAccepted && !isRejected) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await updateOrderStatus(
                          widget.order['orderId'], 'Order accepted');
                      widget.onStatusChange();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Order Accepted!'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text('Accept'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await updateOrderStatus(
                          widget.order['orderId'], 'Order rejected');
                      widget.onStatusChange();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Order Rejected!'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text('Reject'),
                  ),
                ],
              ),
            ] else if (isAccepted) ...[
              Text(
                'Order Accepted',
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ] else if (isRejected) ...[
              Text(
                'Order Rejected',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ],
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
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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
