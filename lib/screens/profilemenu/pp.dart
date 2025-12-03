import 'package:flutter/material.dart';

class PrivacyPolicyBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Privacy Policy',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 16),
          Text(
            'Effective Date: August 13, 2025\n\nWelcome to Aayumitra, your trusted smart caretaker companion. '
            'This Privacy Policy explains how we collect, use, and protect your personal information when you use our mobile application.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 24),
          _sectionTitle('Information We Collect'),
          _sectionText(
            '• Personal Information: Name, email address, and profile photo (via Firebase Authentication).\n'
            '• Usage Data: App interactions, preferences, and device information.\n'
            '• Optional Health Inputs: If you choose to enter wellness-related data, it is stored securely and never shared without consent.',
          ),
          SizedBox(height: 24),
          _sectionTitle('How We Use Your Data'),
          _sectionText(
            'Your data is used to:\n'
            '• Authenticate and personalize your experience.\n'
            '• Provide smart caretaker features like reminders and alerts.\n'
            '• Improve app performance and user experience.\n\n'
            'We do not sell or share your personal data with third parties for marketing purposes.',
          ),
          SizedBox(height: 24),
          _sectionTitle('Data Storage & Security'),
          _sectionText(
            'All data is stored securely using Firebase services. We implement encryption and access controls to protect your information. '
            'You can delete your account and associated data at any time via the app settings.',
          ),
          SizedBox(height: 24),
          _sectionTitle('Third-Party Services'),
          _sectionText(
            'We rely on trusted third-party services like Firebase Authentication and Firestore. These services comply with industry-standard privacy and security practices.',
          ),
          SizedBox(height: 24),
          _sectionTitle('User Control & Consent'),
          _sectionText(
            'You can update or delete your personal data anytime. By using Aayumitra, you consent to this Privacy Policy.',
          ),
          SizedBox(height: 24),
          _sectionTitle('Contact Us'),
          _sectionText(
            'Email: aayumitra.support@example.com\nPhone: +91-XXXXXXXXXX',
          ),
          SizedBox(height: 24),
          _sectionTitle('Updates to This Policy'),
          _sectionText(
            'We may update this Privacy Policy from time to time. Changes will be posted within the app and on our official site.',
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxW = constraints.maxWidth - 12; // small safety margin
        return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxW),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF00897B), Color(0x3300897B)],
              ),
            ),
            child: Text(
              title,
              softWrap: true,
              overflow: TextOverflow.visible,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _sectionText(String text) {
    return Text(text, style: TextStyle(fontSize: 16, height: 1.5));
  }
}
