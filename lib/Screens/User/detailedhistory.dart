import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class Myorders extends StatelessWidget {
  Myorders({super.key});

  final List<Map<String, dynamic>> myordes = [
    {
      "image": "assets/Image/WhatsApp Image 2024-08-07 at 17.10.18_23cfa924.jpg",
      "name": "Neurobion Forte 30 Tablets",
      "Qty": "2",
      "price": "₹ 38.35",
    },
    {
      "image": "assets/Image/WhatsApp Image 2024-08-07 at 17.10.18_23cfa924.jpg",
      "name": "Neurobion Forte 30 Tablets",
      "Qty": "2",
      "price": "₹ 200.35",
    },
    {
      "image": "assets/Image/WhatsApp Image 2024-08-07 at 17.10.18_23cfa924.jpg",
      "name": "Neurobion Forte 30 Tablets",
      "Qty": "2",
      "price": "₹ 380.35",
    },
    {
      "image": "assets/Image/WhatsApp Image 2024-08-07 at 17.10.18_23cfa924.jpg",
      "name": "Neurobion Forte 30 Tablets",
      "Qty": "2",
      "price": "₹ 38.35",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(242, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: const Text(
          "Order ID: 22261052067",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 4),
          const ListTile(
            tileColor: Colors.white,
            leading: Icon(Icons.calendar_today_outlined, color: Colors.grey),
            title: Text(
              "Delivery by",
              style: TextStyle(color: Colors.grey),
            ),
            trailing: Text("August 12"),
          ),
          const SizedBox(height: 4),
          const ListTile(
            tileColor: Colors.white,
            leading: Icon(Icons.home_outlined, color: Colors.grey, size: 30),
            title: Row(
              children: [
                Text("Deliver to", style: TextStyle(color: Colors.grey)),
                SizedBox(width: 7),
                Text("Home, 673008"),
              ],
            ),
            subtitle: Text(
              "krishnarchana, calicut 673008, kerala, Kozhikode kerala",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Shipment Items",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: myordes.length,
                itemBuilder: (context, index) {
                  final myorde = myordes[index];
                  return ListTile(
                    leading: Image.asset(
                      myorde['image'],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      myorde['name'],
                      style: const TextStyle(fontSize: 16),
                    ),
                    subtitle: Text("Qty: ${myorde['Qty']}"),
                    trailing: Text(
                      myorde['price'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  height: 30,
                  thickness: 1.5,
                  color: Color.fromARGB(255, 220, 220, 220),
                  endIndent: 16,
                  indent: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            tileColor: Colors.white,
            leading: const Text(
              "Cancel order",
              style: TextStyle(fontSize: 14),
            ),
            trailing: IconButton(
              onPressed: () {
                // Implement cancellation
              },
              icon: const Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.all(13.0),
            child: Text(
              "Payment Summary",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "MRP Total",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text("₹ 110.35")
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Discount",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text("- ₹ 5.35")
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Shipping Fee",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text("+ ₹ 49.35")
                      ],
                    ),
                    const SizedBox(height: 15),
                    const DottedLine(dashColor: Colors.grey),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Bill Amount",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          "₹ 154.00",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: const Color.fromARGB(255, 201, 243, 202),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Total Saving",
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "₹ 5.50 ",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
