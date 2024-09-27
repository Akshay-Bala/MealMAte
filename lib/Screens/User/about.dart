import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.deepOrange.shade500,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network("https://th.bing.com/th/id/OIP.Cu2kO6hRv2cCYsrCaAkilQHaEK?rs=1&pid=ImgDetMain"),
            const SizedBox(height: 16),
            const Text(
              'Welcome to MEALMATE',
            ),
            const SizedBox(height: 8),
            const Text(
              'Our mission is to make food delivery as seamless and enjoyable as possible, offering a wide variety of dining options and ensuring timely delivery.',
            ),
            const SizedBox(height: 16),
            const Text(
              'Features:',
            ),
            const Text(
              '• Easy order tracking\n• Real-time updates\n• Wide range of restaurants\n• Contactless delivery',
            ),
            const SizedBox(height: 16),
            const Text(
              'Contact Us:',
            ),
            const Text(
              'For support or feedback, reach out to us at [email@example.com] or call us at [Phone Number].',
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to contact or website
                },
                child: const Text('Visit Our Website'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
