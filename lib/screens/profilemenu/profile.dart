// import 'package:flutter/material.dart';
// import 'settings.dart';
// import 'privacypolicy.dart';
// import 'accountsettings.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

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

//   void _openSettings(BuildContext context) {
//     // Navigator.push(
//     //   context,
//     //   MaterialPageRoute(builder: (_) => const SettingsPage()),
//     // );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 40),
//           const CircleAvatar(
//             radius: 50,
//             backgroundImage: AssetImage('assets/images/profile.jpg'),
//           ),
//           const SizedBox(height: 12),
//           const Text(
//             'John Doe',
//             style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 4),
//           const Text(
//             'johndoe@example.com',
//             style: TextStyle(color: Colors.grey),
//           ),
//           const SizedBox(height: 24),
//           const Divider(thickness: 1),
//           Expanded(
//             child: ListView(
//               children: [
//                 ListTile(
//                   leading: const Icon(Icons.settings),
//                   title: const Text('Settings'),
//                   trailing: const Icon(Icons.arrow_forward_ios),
//                   onTap: () => _openSettings(context),
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.person),
//                   title: const Text('Account Settings'),
//                   trailing: const Icon(Icons.arrow_forward_ios),
//                   onTap: () => _openAccountSettings(context),
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.privacy_tip),
//                   title: const Text('Privacy Policy'),
//                   trailing: const Icon(Icons.arrow_forward_ios),
//                   onTap: () => _openPrivacyPolicy(context),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
