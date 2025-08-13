import 'package:aayumitra/screens/profilemenu/animatedside.dart';
import 'package:flutter/material.dart';
// import 'animated_side_sheet.dart';

class PrivacyPolicySheet extends StatelessWidget {
  const PrivacyPolicySheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSideSheet(
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Your privacy policy content goes here. Explain how user data is handled, stored, and protected.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

void showPrivacyPolicySheet(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Privacy Policy",
    // ignore: deprecated_member_use
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 350),
    pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
    transitionBuilder: (context, anim1, anim2, child) {
      return const PrivacyPolicySheet();
    },
  );
}
