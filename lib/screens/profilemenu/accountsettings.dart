import 'package:aayumitra/screens/onboard/splash_screen.dart';
import 'package:flutter/material.dart';
// import 'splash_screen.dart';



class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  void _editProfilePic(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile Picture'),
        content: const Text('Profile picture editing UI goes here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _editName(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Name'),
        content: const TextField(
          decoration: InputDecoration(hintText: 'Enter new name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _editPhone(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Phone Number'),
        content: const TextField(
          decoration: InputDecoration(hintText: 'Enter new phone number'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const SplashScreen()),
                (route) => false,
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _manageDevices(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Manage Devices'),
        content: const Text('Add or remove devices UI goes here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account Settings')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: const Text('Edit Profile Picture'),
            onTap: () => _editProfilePic(context),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit Name'),
            onTap: () => _editName(context),
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Edit Phone Number'),
            onTap: () => _editPhone(context),
          ),
          ListTile(
            leading: const Icon(Icons.devices),
            title: const Text('Add or Remove Devices'),
            onTap: () => _manageDevices(context),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}
