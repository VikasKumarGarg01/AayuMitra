import 'package:aayumitra/screens/profilemenu/animatedside.dart';
import 'package:aayumitra/screens/profilemenu/pp.dart';
import 'package:flutter/material.dart';
// import 'animated_side_sheet.dart';

class PrivacyPolicySheet extends StatelessWidget {
  const PrivacyPolicySheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSideSheet(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PrivacyPolicyBody(),
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
