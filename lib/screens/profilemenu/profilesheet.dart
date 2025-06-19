import 'dart:ui';
import 'package:aayumitra/screens/profilemenu/accountsettings.dart';
import 'package:aayumitra/screens/profilemenu/privacypolicy.dart';
import 'package:aayumitra/screens/profilemenu/contactus.dart';
import 'package:flutter/material.dart';

class ProfileSheet extends StatefulWidget {
  const ProfileSheet({super.key});

  @override
  State<ProfileSheet> createState() => _ProfilesheetState();
}

class _ProfilesheetState extends State<ProfileSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  void _openAccountSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AccountSettingsPage()),
    );
  }

  void _openPrivacyPolicy(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PrivacyPolicyPage()),
    );
  }

  void _contactUs(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ContactUsSheet()),
    );
  }

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
    return Stack(
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

        // Profile panel
        SlideTransition(
          position: _slideAnimation,
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: 0.60,
              heightFactor: 0.80,
              child: Material(
                color: const Color.fromARGB(255, 240, 239, 239),
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(32),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: CircleAvatar(
                            radius: 48,
                            backgroundImage: AssetImage(
                              'assets/images/profile.png',
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Center(
                          child: Column(
                            children: [
                              Text(
                                'Robert Smith',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Robert@gmail.com',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                'Mumbai 400050',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                '222-444-1111',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child: ListView(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.language),
                                title: const Text('Language'),
                                onTap: () {},
                              ),
                              //
                              ListTile(
                                leading: const Icon(Icons.history),
                                title: const Text('Recent Orders'),
                                onTap: () {},
                              ),

                              // ListTile(
                              //   leading: const Icon(Icons.settings),
                              //   title: const Text('Settings'),
                              //   // trailing: const Icon(Icons.arrow_forward_ios),
                              //   onTap: () => _openSettings(context),
                              // ),
                              ListTile(
                                leading: const Icon(Icons.person),
                                title: const Text('Account Settings'),
                                // trailing: const Icon(Icons.arrow_forward_ios),
                                onTap: () => _openAccountSettings(context),
                              ),
                              ListTile(
                                leading: const Icon(Icons.privacy_tip),
                                title: const Text('Privacy Policy'),
                                // trailing: const Icon(Icons.arrow_forward_ios),
                                onTap: () => _openPrivacyPolicy(context),
                              ),
                              ListTile(
                                leading: const Icon(Icons.contact_support),
                                title: const Text('Contact Us'),
                                onTap: () {
                                  _contactUs(context);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.people),
                                title: const Text('Meet Our Team'),
                                onTap: () {},
                              ),
                            ],
                          ),
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
    );
  }
}
