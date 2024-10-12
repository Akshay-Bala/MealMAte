import 'package:flutter/material.dart';

class Rating extends StatefulWidget {
   Rating({super.key});

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<Rating> {
  double _rating = 0.0;
  final _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Rate Us'),
        backgroundColor: Colors.green.shade500,
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              'We value your feedback!',
            ),
             SizedBox(height: 16),
             Text(
              'Rate your experience:',
            ),
             SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.green,
                    size: 36,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1.0;
                    });
                  },
                );
              }),
            ),
             SizedBox(height: 16),
             Text(
              'Leave us a message:',
            ),
             SizedBox(height: 8),
            TextField(
              controller: _feedbackController,
              maxLines: 4,
              decoration:  InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Type your feedback here...',
              ),
            ),
             SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                
                onPressed: () {
                  final feedback = _feedbackController.text;
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text('Thank you for your feedback!')),
                  );
                },
                child:  Text('Submit Feedback'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

