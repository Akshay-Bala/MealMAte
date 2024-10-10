import 'package:flutter/material.dart';
import 'package:mealmate/Screens/User/detailedhistory.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Order History',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: OrderHistoryPage(),
    );
  }
}

class OrderHistoryPage extends StatelessWidget {
  final List<Order> orders = [
    Order(
      date: '2023-08-01',
      restaurant: 'Pizza Palace',
      items: ['Pepperoni Pizza', 'Garlic Bread', 'Coke'],
      total: 29.99,
    ),
    Order(
      date: '2023-07-28',
      restaurant: 'Sushi World',
      items: ['Salmon Sushi', 'Miso Soup', 'Green Tea'],
      total: 18.50,
    ),
    Order(
      date: '2023-07-20',
      restaurant: 'Burger Town',
      items: ['Cheeseburger', 'Fries', 'Milkshake'],
      total: 14.75,
    ),
  ];

   OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return OrderCard(order: orders[index]);
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

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Order Date:',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      order.date,
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Payment: Cash on delivery',
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const Text(
                      'Savings: ₹154', // Example of hardcoded savings
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(
              height: 30,
              thickness: 2,
              color: Color.fromARGB(234, 234, 234, 234),
              endIndent: 0,
              indent: 0,
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(7),
              leading: Container(
                width: 60,
                height: 60,
                color: Colors.orange.shade100, // Placeholder for image
                child: const Icon(
                  Icons.fastfood,
                  size: 40,
                  color: Colors.orange,
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.restaurant,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Text(
                      'Delivered',
                      style: TextStyle(color: Colors.green, fontSize: 14),
                    ),
                    const Text(
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
                  const SizedBox(
                    height: 7,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Myorders(),));
                                        },
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
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


