import 'dart:ui';

import 'package:flutter/material.dart';

class ContactUsSheet extends StatefulWidget {
  const ContactUsSheet({super.key});

  @override
  State<ContactUsSheet> createState() => _ContactUsSheetState();
}

class _ContactUsSheetState extends State<ContactUsSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double sheetWidth = MediaQuery.of(context).size.width * 0.6;

    return Stack(
      children: [
        // Tap outside to close
        // Positioned.fill(
        //   child: GestureDetector(
        //     onTap: () => Navigator.pop(context),
        //     child: Container(
        //       color: const Color.fromARGB(0, 0, 0, 0).withOpacity(0.2),
        //     ),
        //   ),
        // ),
        Stack(
          children: [
            // Blurred background
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: const Color.fromARGB(97, 255, 255, 255),
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SlideTransition(
                position: _slideAnimation,
                child: FractionallySizedBox(
                  widthFactor: 0.6,
                  child: Material(
                    borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(32),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 40,
                        horizontal: 24,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Contact Us',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 24),
                            ListTile(
                              leading: const Icon(
                                Icons.email,
                                color: Colors.teal,
                              ),
                              title: const Text('Email'),
                              subtitle: const Text('support@aayumitra.com'),
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.location_on,
                                color: Colors.teal,
                              ),
                              title: const Text('Office Address'),
                              subtitle: const Text(
                                '123 Health Street, Wellness City, 123456',
                              ),
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.phone,
                                color: Colors.teal,
                              ),
                              title: const Text('Phone'),
                              subtitle: const Text('+91 98765 43210'),
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.help_outline,
                                color: Colors.teal,
                              ),
                              title: const Text('FAQs'),
                              subtitle: const Text(
                                'Visit our FAQ section on the website.',
                              ),
                              onTap: () {
                                // Optionally open FAQ page or link
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// To show this sheet (just like profile menu):
void showContactUsSheet(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Contact Us",
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 350),
    pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
    transitionBuilder: (context, anim1, anim2, child) {
      return ContactUsSheet();
    },
  );
}
