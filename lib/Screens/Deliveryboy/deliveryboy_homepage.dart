import 'package:flutter/material.dart';



class DeliveryboyHomepage extends StatelessWidget {
  const DeliveryboyHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: const [
          Icon(Icons.bike_scooter), // Top-right bike icon
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Cards Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard("Orders Completed", "25"),
                _buildStatCard("Orders Cancelled", "06"),
              ],
            ),
            const SizedBox(height: 16.0),
            _buildStatCard("Total Earnings", "₹ 850", expanded: true),
            const SizedBox(height: 16.0),
            
            // New Order Section
            _buildNewOrderCard(),
          ],
        ),
      ),
      
    );
  }

  // Method to build stat cards
  Widget _buildStatCard(String title, String value, {bool expanded = false}) {
    return Expanded(
      flex: expanded ? 2 : 1,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                value,
                style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build new order card
  Widget _buildNewOrderCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "New Order",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Text(
              "Id: #123455684",
              style: TextStyle(fontSize: 14.0),
            ),
            const SizedBox(height: 8.0),
            const Text(
              "From: 2nd Street Anna Nagar, Karaikudi",
              style: TextStyle(fontSize: 14.0),
            ),
            const Text(
              "To: 3rd Floor, Anna Towers, Karaikudi",
              style: TextStyle(fontSize: 14.0),
            ),
            const SizedBox(height: 8.0),
            const Text(
              "₹ 150",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Reject Order
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text("Reject"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Accept Order
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text("Accept"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
