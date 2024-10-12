import 'package:flutter/material.dart';
import 'package:mealmate/Screens/login.dart';

class Profileall extends StatelessWidget {
   Profileall({super.key});

  void _navigateTo(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.green,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 40, // Adjust radius to control the avatar size
                        backgroundImage: NetworkImage(currentuserdata['imgUrl'] ?? 'null'),
                      ),
                    ),
                     SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentuserdata['name'], // Replace with actual user name
                          style:  TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          currentuserdata['email'], // Replace with actual user email
                          style:  TextStyle(
                            color: Colors.white70,
                            fontSize: 16.0,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _navigateTo(context, '/view-activity');
                          },
                          child:  Text(
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
             SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildListTile(context, 'Rating', Icons.star, 'Rating'),
                  _buildDivider(),
                  // _buildListTile(context, 'Payment Settings', Icons.payment, 'Payment'),
                  // _buildDivider(),
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
          backgroundColor: Colors.green,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          title,
          style:  TextStyle(fontSize: 16, color: Colors.black),
        ),
        trailing:  Icon(Icons.arrow_forward_ios, color: Colors.grey),
      ),
    );
  }

  Divider _buildDivider() {
    return  Divider(height: 10, endIndent: 25, indent: 15);
  }
}
