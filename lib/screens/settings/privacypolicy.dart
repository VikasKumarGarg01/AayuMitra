import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Your privacy policy content goes here. '
          'Explain how user data is handled, stored, and protected.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
