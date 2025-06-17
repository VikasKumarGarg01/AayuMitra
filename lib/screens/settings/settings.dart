// import 'package:flutter/material.dart';
// import 'privacypolicy.dart';
// import 'accountsettings.dart';

// class SettingsPage extends StatelessWidget {
//   const SettingsPage({super.key});

//   void _openAccountSettings(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => const AccountSettingsPage()),
//     );
//   }

//   void _openPrivacyPolicy(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => const PrivacyPolicyPage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Settings')),
//       body: ListView(
//         children: [
//           ListTile(
//             leading: const Icon(Icons.person),
//             title: const Text('Account Settings'),
//             onTap: () => _openAccountSettings(context),
//           ),
//           ListTile(
//             leading: const Icon(Icons.privacy_tip),
//             title: const Text('Privacy Policy'),
//             onTap: () => _openPrivacyPolicy(context),
//           ),
//         ],
//       ),
//     );
//   }
// }
