import 'package:flutter/material.dart';

class DeliveryboyHomepage extends StatelessWidget {
   DeliveryboyHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Dashboard"),
        backgroundColor: Colors.lightBlueAccent,
        actions:  [
          Icon(Icons.bike_scooter, color: Colors.white), // Top-right bike icon
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Cards Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard("Orders Completed", "25", Colors.lightGreen[100]!),
                _buildStatCard("Orders Cancelled", "06", Colors.red[100]!),
              ],
            ),
             SizedBox(height: 16.0),
            _buildStatCard("Total Earnings", "₹ 850", Colors.blue[100]!, expanded: true),
             SizedBox(height: 16.0),

            // New Order Section
            _buildNewOrderCard(),
          ],
        ),
      ),
    );
  }

  // Method to build stat cards
  Widget _buildStatCard(String title, String value, Color color, {bool expanded = false}) {
    return Expanded(
      flex: expanded ? 2 : 1,
      child: Card(
        elevation: 4,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding:  EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                title,
                style:  TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
               SizedBox(height: 8.0),
              Text(
                value,
                style:  TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              "New Order",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
             SizedBox(height: 8.0),
             Text(
              "Id: #123455684",
              style: TextStyle(fontSize: 14.0),
            ),
             SizedBox(height: 8.0),
             Text(
              "From: 2nd Street Anna Nagar, Karaikudi",
              style: TextStyle(fontSize: 14.0),
            ),
             Text(
              "To: 3rd Floor, Anna Towers, Karaikudi",
              style: TextStyle(fontSize: 14.0),
            ),
             SizedBox(height: 8.0),
             Text(
              "₹ 150",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
             SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Reject Order
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child:  Text("Reject"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Accept Order
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child:  Text("Accept"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}