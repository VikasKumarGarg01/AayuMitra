import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:aayumitra/screens/onboard/splash_screen.dart';
import 'package:aayumitra/screens/profilemenu/animatedside.dart';

class AccountSettingsSheet extends StatelessWidget {
  final String name;
  final String email;
  final String address;
  final String phone;
  final Function(String, String) onUpdate;

  const AccountSettingsSheet({
    super.key,
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.onUpdate,
  });

  void _editField(
    BuildContext context,
    String field,
    String currentValue,
  ) async {
    final controller = TextEditingController(text: currentValue);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $field'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: 'Enter new $field'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (result != null && result.trim().isNotEmpty) {
      onUpdate(field, result.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSideSheet(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Account Settings',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Name'),
            subtitle: Text(name),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _editField(context, 'Name', name),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Email'),
            subtitle: Text(email),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _editField(context, 'Email', email),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Address'),
            subtitle: Text(address),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _editField(context, 'Address', address),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Phone'),
            subtitle: Text(phone),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _editField(context, 'Phone', phone),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.lock_reset),
            title: const Text('Reset Password'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/forgot-password');
            },
          ),
          ListTile(
            leading: const Icon(Icons.devices),
            title: const Text('Add/Remove Device'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/bluetooth');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Are you sure?'),
                  content: const Text('Do you really want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );
              if (shouldLogout == true) {
                // Restart the app (using restart_app package or similar)
                // import 'package:restart_app/restart_app.dart';
                // Restart.restartApp();
                // Or, if you want to just pop to the root:
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            },
          ),
        ],
      ),
    );
  }
}

void showAccountSettingsSheet(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Account Settings",
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 350),
    pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
    transitionBuilder: (context, anim1, anim2, child) {
      // Provide dummy/default values or fetch actual user data as needed
      return AccountSettingsSheet(
        name: '',
        email: '',
        address: '',
        phone: '',
        onUpdate: (field, value) {},
      );
    },
  );
}
