import 'package:aayumitra/screens/profilemenu/animatedside.dart';
import 'package:aayumitra/services/glass_widgets.dart';
import 'package:flutter/material.dart';
// import 'animated_side_sheet.dart';

class MeetOurTeamSheet extends StatelessWidget {
  const MeetOurTeamSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final team = [
      {
        'name': 'Vikas Garg',
        'email': 'vikasgarg10@aayumitra.com',
        'phone': '+91 98158 30668',
        'role': 'App Developer',
        'img': 'assets/images/vkg.png',
      },
      {
        'name': 'Yashvi',
        'email': 'yashvi20@aayumitra.com',
        'phone': '+91 75686 87806',
        'role': 'UI/UX Designer',
        'img': 'assets/images/yashi.png',
      },
      {
        'name': 'Nikhil Mittal',
        'email': 'nikhilmittal1112@aayumitra.com',
        'phone': '+91 8283901308',
        'role': 'Backend Engineer',
        'img': 'assets/images/mittal.png',
      },
      {
        'name': 'Jiya Aggarwal',
        'email': 'jiyaaggarwal@aayumitra.com',
        'phone': '+91 80145 50000',
        'role': 'ML Developer',
        'img': 'assets/images/jiya.png',
      },
      {
        'name': 'Yugansh Garg',
        'email': 'yuganshgarg@aayumitra.com',
        'phone': '+91 77105 01260',
        'role': 'Hardware Developer',
        'img': 'assets/images/yugansh.png',
      },
    ];

    return AnimatedSideSheet(
      child: GlassCard(
        blur: 26,
        opacity: Theme.of(context).brightness == Brightness.dark ? 0.22 : 0.9,
        borderOpacity: Theme.of(context).brightness == Brightness.dark ? 0.55 : 0.35,
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
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 5),
          const Text(
            'Meet Our Team',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          ...team.map(
            (member) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundImage: AssetImage(member['img']!),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    member['name']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    member['role']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 28,
                        width: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF00897B), Color(0x3300897B)],
                          ),
                        ),
                        child: const Center(
                          child: Icon(Icons.email, color: Colors.white, size: 14),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(child: Text(member['email']!)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 28,
                        width: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF00897B), Color(0x3300897B)],
                          ),
                        ),
                        child: const Center(
                          child: Icon(Icons.phone, color: Colors.white, size: 14),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(child: Text(member['phone']!)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
          ),
        ),
      ),
    );
  }
}

void showMeetOurTeamSheet(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Meet Our Team",
    // ignore: deprecated_member_use
    barrierColor: Theme.of(context).colorScheme.scrim.withOpacity(0.60),
    transitionDuration: const Duration(milliseconds: 380),
    pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
    transitionBuilder: (context, anim1, anim2, child) {
      return const SafeArea(
        minimum: EdgeInsets.all(16),
        child: MeetOurTeamSheet(),
      );
    },
  );
}
