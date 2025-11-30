import 'dart:ui';
import 'package:aayumitra/screens/profilemenu/accountsettingsheet.dart';
import 'package:aayumitra/screens/profilemenu/contactus.dart';
import 'package:aayumitra/screens/profilemenu/language.dart';
import 'package:aayumitra/screens/profilemenu/meetteam.dart';
import 'package:aayumitra/screens/profilemenu/privacy.dart';
// import 'package:aayumitra/screens/profilemenu/contactus.dart';
import 'package:flutter/material.dart';
import 'package:aayumitra/screens/usermodel/care_models.dart';

class ProfileSheet extends StatefulWidget {
  const ProfileSheet({super.key});

  @override
  State<ProfileSheet> createState() => _ProfilesheetState();
}

class _ProfilesheetState extends State<ProfileSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  String _name = '';
  String _email = '';
  String _address = '';
  String _phone = '';

  void _updateProfileField(String field, String value) {
    setState(() {
      if (field == 'Name') _name = value;
      if (field == 'Email') _email = value;
      if (field == 'Address') _address = value;
      if (field == 'Phone') _phone = value;
    });
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
              color: Theme.of(context).colorScheme.surface.withOpacity(0.6),
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
                color: Theme.of(context).colorScheme.surface,
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
                            radius: 100,
                            backgroundImage: AssetImage(
                              'assets/images/profile1.png',
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: ValueListenableBuilder(
                            valueListenable: careContextNotifier,
                            builder: (context, ctx, _) {
                              final caregiver = ctx.caregiver;
                              final elderly = ctx.elderly;
                              final displayName = caregiver?.name ?? elderly?.name ?? '';
                              final displayEmail = _email.isNotEmpty ? _email : '';
                              final displayAddress = elderly?.address ?? caregiver?.address ?? '';
                              final displayPhone = elderly?.phone ?? caregiver?.phone ?? '';
                              return Column(
                                children: [
                                  Text(
                                    displayName.isEmpty ? 'AayuMitra User' : displayName,
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  if (displayEmail.isNotEmpty)
                                    Text(
                                      displayEmail,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withOpacity(0.7),
                                          ),
                                    ),
                                  if (displayAddress.isNotEmpty)
                                    Text(
                                      displayAddress,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withOpacity(0.7),
                                          ),
                                    ),
                                  if (displayPhone.isNotEmpty)
                                    Text(
                                      displayPhone,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withOpacity(0.7),
                                          ),
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child: ListView(
                            children: [
                              ListTile(
                                leading: Icon(
                                  Icons.language,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                title: const Text('Language'),
                                onTap: () {
                                  Navigator.pop(context);
                                  showLanguageSheet(context, (langCode) {
                                    // Set app language here
                                  });
                                },
                              ),
                              //
                              // ListTile(
                              //   leading: const Icon(Icons.history),
                              //   title: const Text('Recent Orders'),
                              //   onTap: () {},
                              // ),

                              // ListTile(
                              //   leading: const Icon(Icons.settings),
                              //   title: const Text('Settings'),
                              //   // trailing: const Icon(Icons.arrow_forward_ios),
                              //   onTap: () => _openSettings(context),
                              // ),
                              ListTile(
                                leading: Icon(
                                  Icons.person,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                title: const Text('Account Settings'),
                                // trailing: const Icon(Icons.arrow_forward_ios),
                                onTap: () {
                                  Navigator.pop(context);
                                  showGeneralDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    barrierLabel: "Account Settings",
                                    // ignore: deprecated_member_use
                                    barrierColor: Colors.black.withOpacity(0.3),
                                    transitionDuration: const Duration(
                                      milliseconds: 350,
                                    ),
                                    pageBuilder: (context, anim1, anim2) =>
                                        const SizedBox.shrink(),
                                    transitionBuilder:
                                        (context, anim1, anim2, child) {
                                          return AccountSettingsSheet(
                                            name: _name,
                                            email: _email,
                                            address: _address,
                                            phone: _phone,
                                            onUpdate: _updateProfileField,
                                          );
                                        },
                                  );
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.privacy_tip,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                title: const Text('Privacy Policy'),
                                // trailing: const Icon(Icons.arrow_forward_ios),
                                onTap: () {
                                  Navigator.pop(context);
                                  showPrivacyPolicySheet(context);
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.contact_support,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                title: const Text('Contact Us'),
                                onTap: () {
                                  Navigator.pop(context);
                                  showContactUsSheet(context);
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.group,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                title: const Text('Meet Our Team'),
                                onTap: () {
                                  Navigator.pop(context);
                                  showMeetOurTeamSheet(context);
                                },
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
