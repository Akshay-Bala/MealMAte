import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
   AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('About Us'),
        backgroundColor: Colors.green.shade500,
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network("https://th.bing.com/th/id/OIP.Cu2kO6hRv2cCYsrCaAkilQHaEK?rs=1&pid=ImgDetMain"),
             SizedBox(height: 16),
             Text(
              'Welcome to MEALMATE',
            ),
             SizedBox(height: 8),
             Text(
              'Our mission is to make food delivery as seamless and enjoyable as possible, offering a wide variety of dining options and ensuring timely delivery.',
            ),
             SizedBox(height: 16),
             Text(
              'Features:',
            ),
             Text(
              '• Easy order tracking\n• Real-time updates\n• Wide range of restaurants\n• Contactless delivery',
            ),
             SizedBox(height: 16),
             Text(
              'Contact Us:',
            ),
             Text(
              'For support or feedback, reach out to us at [email@example.com] or call us at [Phone Number].',
            ),
             Spacer(),
            // Center(
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Navigate to contact or website
            //     },
            //     child:  Text('Visit Our Website'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
