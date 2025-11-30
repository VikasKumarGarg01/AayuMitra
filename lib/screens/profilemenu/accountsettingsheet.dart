import 'package:flutter/material.dart';
import 'package:aayumitra/screens/profilemenu/animatedside.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restart_app/restart_app.dart';
import 'package:aayumitra/services/care_context_persistence.dart';
import 'package:aayumitra/screens/usermodel/care_models.dart';
import 'package:aayumitra/screens/signin/userselection/caregiver_details_page.dart';

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
            leading: const Icon(Icons.refresh, color: Colors.teal),
            title: const Text('Change Details'),
            subtitle: const Text('Re-enter caregiver & elderly info'),
            onTap: () async {
              Navigator.pop(context);
              // Keep existing piId and appId; re-enter details and upsert will overwrite
              // Clear local caregiver/elderly but preserve IDs
              final prev = careContextNotifier.value;
              careContextNotifier.value = CareContext(
                appId: prev.appId,
                piId: prev.piId,
              );
              await CareContextStorage.save(careContextNotifier.value);
              // Navigate to caregiver details
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CaregiverDetailsPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.teal),
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
                await FirebaseAuth.instance.signOut();
                // Clear context too
                careContextNotifier.value = CareContext();
                await CareContextStorage.save(careContextNotifier.value);
                Restart.restartApp();
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
    // ignore: deprecated_member_use
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
