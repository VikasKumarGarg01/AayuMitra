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
        // Stronger blur for liquid glass look
        blur: 18,
        // Dynamic opacity tuned for dark/light for better legibility
        opacity: Theme.of(context).brightness == Brightness.dark ? 0.22 : 1,
        // Slightly more visible border in dark mode
        borderOpacity: Theme.of(context).brightness == Brightness.dark ? 0.55 : 0.35,
        borderRadius: const BorderRadius.all(Radius.circular(28)),
        // Accent border aligns with app primary
        accentBorder: Theme.of(context).colorScheme.primary.withOpacity(0.65),
        
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            // Subtle gradient tint inside the glass
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(
                    Theme.of(context).brightness == Brightness.dark ? 0.12 : 0.08),
                Theme.of(context).colorScheme.secondary.withOpacity(
                    Theme.of(context).brightness == Brightness.dark ? 0.10 : 0.06),
              ],),
          ),
          child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                        width: 1.2,
                      ),
                    ),
                    child: const Icon(Icons.settings, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Account Settings',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Divider(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.25),
                thickness: 0.7,
              ),
              const SizedBox(height: 8),
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
                subtitle: 'Sign out and restart app',
                onTap: () async {
                  final shouldLogout = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      title: Text(
                        'Are you sure?',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      content: Text(
                        'Do you really want to logout?',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
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
      ),
   ) );
  }
}

Widget _tile(BuildContext context,{required IconData icon,required Color color,required String title,String? subtitle,required VoidCallback onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            height: 48,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              // Slight gradient for icon tile
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withOpacity(0.20),
                  color.withOpacity(0.08),
                ],
              ),
              border: Border.all(
                color: color.withOpacity(0.30),
                width: .8,
              ),
            ),
            child: Center(child: Icon(icon, color: color, size: 22)),
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
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.75),
                        ),
                  ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            size: 22,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.9),
          ),
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
    barrierColor: Theme.of(context).colorScheme.scrim.withOpacity(0.60),
    transitionDuration: const Duration(milliseconds: 380),
    pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
    transitionBuilder: (context, anim1, anim2, child) {
      // Provide dummy/default values or fetch actual user data as needed
      return SafeArea(
        minimum: const EdgeInsets.all(16),
        child: AccountSettingsSheet(
          name: '',
          email: '',
          address: '',
          phone: '',
          onUpdate: (field, value) {},
        ),
      );
    },
  );
}
