import 'package:aayumitra/screens/profilemenu/animatedside.dart';
import 'package:aayumitra/services/glass_widgets.dart';
import 'package:flutter/material.dart';

// class PrivacyPolicySheet extends StatelessWidget {
//   const PrivacyPolicySheet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSideSheet(
//       child: const Padding(
//         padding: EdgeInsets.all(8.0),
//         child: Text(
//           'Your privacy policy content goes here. Explain how user data is handled, stored, and protected.',
//           style: TextStyle(fontSize: 16),
//         ),
//       ),
//     );
//   }
// }

// */
class ContactUsSheet extends StatelessWidget {
  const ContactUsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSideSheet(
      child: GlassCard(
        blur: 26,
        opacity: Theme.of(context).brightness == Brightness.dark ? 0.22 : 1,
        borderOpacity: Theme.of(context).brightness == Brightness.dark ? 0.55 : 0.35,
        borderRadius: const BorderRadius.all(Radius.circular(28)),
        accentBorder: Theme.of(context).colorScheme.primary.withOpacity(0.6),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(
                    Theme.of(context).brightness == Brightness.dark ? 0.12 : 0.08),
                Theme.of(context).colorScheme.secondary.withOpacity(
                    Theme.of(context).brightness == Brightness.dark ? 0.10 : 0.06),
              ],
            ),
          ),
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Contact Us',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: Container(
              height: 40,
              width: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF00897B),
                    Color(0x3300897B),
                  ],
                ),
                border: Border.all(color: const Color(0x5500897B), width: 0.8),
              ),
              child: const Center(child: Icon(Icons.email, color: Colors.white, size: 20)),
            ),
            title: const Text('Email'),
            subtitle: const Text('support@aayumitra.com'),
          ),
          ListTile(
            leading: Container(
              height: 40,
              width: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF00897B),
                    Color(0x3300897B),
                  ],
                ),
                border: Border.all(color: const Color(0x5500897B), width: 0.8),
              ),
              child: const Center(child: Icon(Icons.location_on, color: Colors.white, size: 20)),
            ),
            title: const Text('Office Address'),
            subtitle: const Text('123 Health Street, Wellness City, 123456'),
          ),
          ListTile(
            leading: Container(
              height: 40,
              width: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF00897B),
                    Color(0x3300897B),
                  ],
                ),
                border: Border.all(color: const Color(0x5500897B), width: 0.8),
              ),
              child: const Center(child: Icon(Icons.phone, color: Colors.white, size: 20)),
            ),
            title: const Text('Phone'),
            subtitle: const Text('+91 98765 43210'),
          ),
          ListTile(
            leading: Container(
              height: 40,
              width: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF00897B),
                    Color(0x3300897B),
                  ],
                ),
                border: Border.all(color: const Color(0x5500897B), width: 0.8),
              ),
              child: const Center(child: Icon(Icons.help_outline, color: Colors.white, size: 20)),
            ),
            title: const Text('FAQs'),
            subtitle: const Text('Visit our FAQ section on the website.'),
          ),
        ],
          ),
        ),
      ),
    );
  }
}

void showContactUsSheet(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Contact Us",
    // ignore: deprecated_member_use
    barrierColor: Theme.of(context).colorScheme.scrim.withOpacity(0.60),
    transitionDuration: const Duration(milliseconds: 380),
    pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
    transitionBuilder: (context, anim1, anim2, child) {
      return const SafeArea(
        minimum: EdgeInsets.all(16),
        child: ContactUsSheet(),
      );
    },
  );
}
