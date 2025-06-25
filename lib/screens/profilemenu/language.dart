import 'package:aayumitra/screens/profilemenu/animatedside.dart';
import 'package:flutter/material.dart';
// import 'animated_side_sheet.dart';

class LanguageSheet extends StatelessWidget {
  final Function(String) onSelect;
  const LanguageSheet({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return AnimatedSideSheet(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Select Language',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('English'),
            onTap: () {
              onSelect('en');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('हिन्दी'),
            onTap: () {
              onSelect('hi');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

void showLanguageSheet(BuildContext context, Function(String) onSelect) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Language",
    // ignore: deprecated_member_use
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 350),
    pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
    transitionBuilder: (context, anim1, anim2, child) {
      return LanguageSheet(onSelect: onSelect);
    },
  );
}
