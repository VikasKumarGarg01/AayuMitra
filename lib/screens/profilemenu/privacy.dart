import 'package:aayumitra/screens/profilemenu/animatedside.dart';
import 'package:aayumitra/screens/profilemenu/pp.dart';
import 'package:aayumitra/services/glass_widgets.dart';
import 'package:flutter/material.dart';
// import 'animated_side_sheet.dart';

class PrivacyPolicySheet extends StatelessWidget {
  const PrivacyPolicySheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSideSheet(
      child: GlassCard(
        blur: 26,
        opacity: Theme.of(context).brightness == Brightness.dark ? 0.22 : 0.9,
        borderOpacity: Theme.of(context).brightness == Brightness.dark ? 0.55 : 0.5,
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
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: PrivacyPolicyBody(),
          ),
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
    barrierColor: Theme.of(context).colorScheme.scrim.withOpacity(0.60),
    transitionDuration: const Duration(milliseconds: 380),
    pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
    transitionBuilder: (context, anim1, anim2, child) {
      return const SafeArea(
        minimum: EdgeInsets.all(16),
        child: PrivacyPolicySheet(),
      );
    },
  );
}
