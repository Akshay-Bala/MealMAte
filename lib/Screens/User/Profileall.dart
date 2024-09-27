import 'package:flutter/material.dart';

class Profileall extends StatelessWidget {
  const Profileall({super.key});

  void _navigateTo(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.deepOrange.shade500,
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: CircleAvatar(
                        radius: 50,
                        // You can set an image here for the avatar if needed.
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Name",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "Email_id",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _navigateTo(context, '/view-activity');
                          },
                          child: const Text(
                            "View Activity",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      _navigateTo(context, 'Rating');
                    },
                    child: const ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.star),
                      ),
                      title: Text('Rating'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  const Divider(height: 10, endIndent: 25, indent: 15),
                  InkWell(
                    onTap: () {
                      _navigateTo(context, 'Payment');
                    },
                    child: const ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.payment),
                      ),
                      title: Text('Payment Settings'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  const Divider(height: 10, endIndent: 25, indent: 15),
                  InkWell(
                    onTap: () {
                      _navigateTo(context, 'About');
                    },
                    child: const ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.info),
                      ),
                      title: Text('About'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  const Divider(height: 10, endIndent: 25, indent: 15),
                 
                  InkWell(
                    onTap: () {
                      _navigateTo(context, 'Login');
                    },
                    child: const ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.logout),
                      ),
                      title: Text('Logout'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  const Divider(height: 10, endIndent: 25, indent: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
