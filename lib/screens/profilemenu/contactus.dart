import 'package:aayumitra/screens/profilemenu/animatedside.dart';
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Contact Us',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.email, color: Colors.teal),
            title: const Text('Email'),
            subtitle: const Text('support@aayumitra.com'),
          ),
          ListTile(
            leading: const Icon(Icons.location_on, color: Colors.teal),
            title: const Text('Office Address'),
            subtitle: const Text('123 Health Street, Wellness City, 123456'),
          ),
          ListTile(
            leading: const Icon(Icons.phone, color: Colors.teal),
            title: const Text('Phone'),
            subtitle: const Text('+91 98765 43210'),
          ),
          ListTile(
            leading: const Icon(Icons.help_outline, color: Colors.teal),
            title: const Text('FAQs'),
            subtitle: const Text('Visit our FAQ section on the website.'),
          ),
        ],
      ),
    );
  }
}

// void showContactUsSheet(BuildContext context) {
//   showGeneralDialog(
//     context: context,
//     barrierDismissible: true,
//     barrierLabel: "Contact Us",
//     // ignore: deprecated_member_use
//     barrierColor: const Color.fromARGB(255, 213, 211, 211).withOpacity(0.3),
//     transitionDuration: const Duration(milliseconds: 350),
//     pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
//     transitionBuilder: (context, anim1, anim2, child) {
//       return const ContactUsSheet();
//     },
//   );
// }

void showContactUsSheet(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Contact Us",
    // ignore: deprecated_member_use
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 350),
    pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
    transitionBuilder: (context, anim1, anim2, child) {
      return const ContactUsSheet();
    },
  );
}
