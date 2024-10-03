import 'package:flutter/material.dart';

class DeliveryboyOrders extends StatelessWidget {
  const DeliveryboyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        backgroundColor: Colors.tealAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.purpleAccent.withOpacity(0.5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTab('All Orders', true),
                  _buildTab('Completed', false),
                  _buildTab('Cancelled', false),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Orders List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildOrderCard(
                    orderId: '1234567890',
                    from: '83, Anna Nagar, Second Street, Karaikudi',
                    to: '23, Kalanivasal, Karaikudi, TN, India 630002',
                    date: '12-05-2024 05:30 PM',
                    amount: '150',
                    status: 'Completed',
                    statusColor: Colors.green,
                  ),
                  _buildOrderCard(
                    orderId: '1234567891',
                    from: '55, Main Road, Karaikudi',
                    to: '12, Kamarajar Street, Karaikudi, TN, India 630002',
                    date: '12-05-2024 06:00 PM',
                    amount: '280',
                    status: 'Cancelled',
                    statusColor: Colors.red,
                  ),
                ],
              ),
            ),
            // Footer
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Completed Orders: 08'),
                  Text('Cancelled Orders: 03'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String label, bool isSelected) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 16,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        color: isSelected ? Colors.white : Colors.grey,
      ),
    );
  }

  Widget _buildOrderCard({
    required String orderId,
    required String from,
    required String to,
    required String date,
    required String amount,
    required String status,
    required Color statusColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 6,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order ID: $orderId'),
                Text(
                  date,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('From: $from'),
            const SizedBox(height: 8),
            Text('To: $to'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹ $amount',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 16,
                    color: statusColor,
                    fontWeight: FontWeight.bold,
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
