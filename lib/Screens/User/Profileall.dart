import 'package:flutter/material.dart';

class Profileall extends StatelessWidget {
  const Profileall({super.key});

  void _navigateTo(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.redAccent,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 50,
                        // You can set an image here for the avatar if needed.
                        backgroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "John Doe", // Replace with actual user name
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "john.doe@example.com", // Replace with actual user email
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16.0,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _navigateTo(context, '/view-activity');
                          },
                          child: const Text(
                            "View Activity",
                            style: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildListTile(context, 'Rating', Icons.star, 'Rating'),
                  _buildDivider(),
                  _buildListTile(context, 'Payment Settings', Icons.payment, 'Payment'),
                  _buildDivider(),
                  _buildListTile(context, 'About', Icons.info, 'About'),
                  _buildDivider(),
                  _buildListTile(context, 'Logout', Icons.logout, 'Login'),
                  _buildDivider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, String title, IconData icon, String routeName) {
    return InkWell(
      onTap: () {
        _navigateTo(context, routeName);
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.redAccent,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
      ),
    );
  }

  Divider _buildDivider() {
    return const Divider(height: 10, endIndent: 25, indent: 15);
  }
}
