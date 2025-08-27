import 'package:flutter/material.dart';
import 'package:fweather/src/constants/color.dart';

class HelpAndFeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Help & Feedback',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.backroundblueW, // App bar background color
      ),
      backgroundColor: AppColors.backroundblue, // Background color
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Help Section
            const Text(
              'Help',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Text(
              'You can find answers to frequently asked questions about the app here. '
              'If you encounter any issues, you can contact us using the form below.',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 20),

            // Feedback Section
            const Text(
              'Feedback',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Text(
              'Your feedback is very valuable to us. Please share your suggestions, complaints, or thanks with us.',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Feedback',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Feedback submission process
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Your feedback has been submitted.')),
                );
              },
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),

            // About the Developers Section
            const Text(
              'About the Developers',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Text(
              'This app has been created using various technologies in the software development process '
              'with the aim of developing a weather application.',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 10),
            const ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text('Cengizhan', style: TextStyle(color: Colors.white)),
              subtitle: Text('Flutter Developer',
                  style: TextStyle(color: Colors.white70)),
            ),
            const ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.monitor_heart_sharp),
              ),
              title: Text('Other Developer',
                  style: TextStyle(color: Colors.white)),
              subtitle: Text('Esmanur (Mental Support) ❤️',
                  style: TextStyle(color: Colors.white70)),
            ),
          ],
        ),
      ),
    );
  }
}
