import 'dart:ui';
import 'package:aayumitra/screens/profilemenu/accountsettingsheet.dart';
import 'package:aayumitra/screens/profilemenu/contactus.dart';
import 'package:aayumitra/screens/profilemenu/meetteam.dart';
import 'package:aayumitra/screens/profilemenu/privacy.dart';
import 'package:flutter/material.dart';
import 'package:aayumitra/screens/usermodel/care_models.dart';
import 'package:aayumitra/services/glass_widgets.dart';

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
              heightFactor: 0.8,
              child: SafeArea(
                child: GlassCard(
                  blur: 20,
                  opacity: Theme.of(context).brightness == Brightness.dark ? 0.08 : 0.16,
                  borderOpacity: 0.30,
                  borderRadius: const BorderRadius.horizontal(right: Radius.circular(32)),
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: _ProfileAvatar(),
                      ),
                      const SizedBox(height: 14),
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
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                if (displayEmail.isNotEmpty)
                                  Text(
                                    displayEmail,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                                        ),
                                  ),
                                if (displayAddress.isNotEmpty)
                                  Text(
                                    displayAddress,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                                        ),
                                  ),
                                if (displayPhone.isNotEmpty)
                                  Text(
                                    displayPhone,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                                        ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 18),
                      Expanded(
                        child: ListView(
                          children: [
                            _GlassTile(
                              icon: Icons.person,
                              title: 'Account Settings',
                              onTap: () {
                                Navigator.pop(context);
                                showGeneralDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  barrierLabel: "Account Settings",
                                  // ignore: deprecated_member_use
                                  barrierColor: Colors.black.withOpacity(0.3),
                                  transitionDuration: const Duration(milliseconds: 350),
                                  pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
                                  transitionBuilder: (context, anim1, anim2, child) {
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
                            // Language feature removed
                            _GlassTile(
                              icon: Icons.privacy_tip,
                              title: 'Privacy Policy',
                              onTap: () {
                                Navigator.pop(context);
                                showPrivacyPolicySheet(context);
                              },
                            ),
                            _GlassTile(
                              icon: Icons.contact_support,
                              title: 'Contact Us',
                              onTap: () {
                                Navigator.pop(context);
                                showContactUsSheet(context);
                              },
                            ),
                            _GlassTile(
                              icon: Icons.group,
                              title: 'Meet Our Team',
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
      ],
    );
  }
}


class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar();
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
      width: 120,
      height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: SweepGradient(
              colors: [
                cs.primary.withOpacity(0.9),
                cs.primary.withOpacity(0.35),
                cs.primary.withOpacity(0.75),
                cs.primary.withOpacity(0.25),
              ],
            ),
          ),
        ),
        Container(
      width: 96,
      height: 96,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
        width: 2.5,
              color: Colors.white.withOpacity(0.75),
            ),
          ),
          child: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile1.png'),
          ),
        ),
      ],
    );
  }
}

class _GlassTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const _GlassTile({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell
          (
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: GlassCard(
            blur: 14,
            opacity: isDark ? 0.10 : 0.18,
            borderOpacity: 0.28,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            accentBorder: cs.primary.withOpacity(0.35),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: cs.primary.withOpacity(isDark ? 0.2 : 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: cs.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
