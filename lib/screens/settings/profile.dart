import 'package:flutter/material.dart';
import 'settings.dart';
import 'privacypolicy.dart';
import 'accountsettings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // void _openSettings(BuildContext context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (_) => const SettingsPage()),
  //   );
  // }

  void _openAccountSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AccountSettingsPage()),
    );
  }

  void _openPrivacyPolicy(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PrivacyPolicyPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        children: [
          const SizedBox(height: 24),
          const CircleAvatar(
            radius: 48,
            backgroundImage: AssetImage('assets/images/profile.jpg'),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'User Name',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 32),
          // ListTile(
          //   leading: const Icon(Icons.settings),
          //   title: const Text('Settings'),
          //   onTap: () => _openSettings(context),
          // ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Account Settings'),
            onTap: () => _openAccountSettings(context),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy Policy'),
            onTap: () => _openPrivacyPolicy(context),
          ),
        ],
      ),
    );
  }
}
