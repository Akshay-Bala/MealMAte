import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mealmate/Screens/User/detailedhistory.dart';

class History extends StatelessWidget {
  var userEmail = FirebaseAuth.instance.currentUser!.email;
   History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Order History'),
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('payments')
            .where('user_email', isEqualTo: userEmail)
            .snapshots(), // Fetch data in real-time
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return  Center(child: Text('No orders found.'));
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
                  date: (orderData['timestamp'] as Timestamp).toDate().toString(),
                  restaurant: orderData['hotel_email'],
                  items: itemNames,
                  total: orderData['total'] as double,
                ),
              );
            },
          );
        },
      ),

    );
  }
}



class Order {
  final String date;
  final String restaurant;
  final List<String> items;
  final double total;

  Order({
    required this.date,
    required this.restaurant,
    required this.items,
    required this.total,
  });
}


class OrderCard extends StatelessWidget {
  final Order order;

   OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin:  EdgeInsets.all(10.0),
      child: Padding(
        padding:  EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      'Order Date:',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      order.date,
                      style:  TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                     Text(
                      'Payment: Cash on delivery',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                     Text(
                      order.total.toString(), // Example of hardcoded savings
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
             Divider(
              height: 30,
              thickness: 2,
              color: Color.fromARGB(234, 234, 234, 234),
              endIndent: 0,
              indent: 0,
            ),
            ListTile(
              contentPadding:  EdgeInsets.all(7),
              leading: Container(
                width: 60,
                height: 60,
                color: Colors.orange.shade100, // Placeholder for image
                child:  Icon(
                  Icons.fastfood,
                  size: 40,
                  color: Colors.orange,
                ),
              ),
              title: Padding(
                padding:  EdgeInsets.only(bottom: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.restaurant,
                      style:  TextStyle(fontSize: 16),
                    ),
                     Text(
                      'Order Confirmed',
                      style: TextStyle(color: Colors.green, fontSize: 14),
                    ),
                     Text(
                      'Delivered by 1 hour',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                   SizedBox(
                    height: 7,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Myorders(),
                        ),
                      );
                    },
                    icon:  Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
