import 'package:flutter/material.dart';
import 'package:aayumitra/services/glass_widgets.dart';
// import 'package:aayumitra/screens/profilemenu/developer_settings.dart';
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
      child: GlassCard(
        blur: 18,
        opacity: Theme.of(context).brightness == Brightness.dark ? 0.10 : 0.18,
        borderOpacity: 0.35,
        borderRadius: const BorderRadius.all(Radius.circular(28)),
        accentBorder: Theme.of(context).colorScheme.primary.withOpacity(0.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Account Settings',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            _tile(
              context,
              icon: Icons.refresh,
              color: Colors.teal,
              title: 'Change Details',
              subtitle: 'Re-enter caregiver & elderly info',
              onTap: () async {
                Navigator.pop(context);
                final prev = careContextNotifier.value;
                careContextNotifier.value = CareContext(
                  appId: prev.appId,
                  piId: prev.piId,
                );
                await CareContextStorage.save(careContextNotifier.value);
                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CaregiverDetailsPage(),
                  ),
                );
              },
            ),
            _tile(
              context,
              icon: Icons.logout,
              color: Colors.redAccent,
              title: 'Logout',
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
                  careContextNotifier.value = CareContext();
                  await CareContextStorage.save(careContextNotifier.value);
                  Restart.restartApp();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _tile(BuildContext context,{required IconData icon,required Color color,required String title,String? subtitle,required VoidCallback onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey[300]
                              : Colors.grey[700],
                        ),
                  ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 22),
        ],
      ),
    ),
  );
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
