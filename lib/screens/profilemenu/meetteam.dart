import 'package:aayumitra/screens/profilemenu/animatedside.dart';
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
                  Text(
                    member['role']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(member['email']!),
                  Text(member['phone']!),
                ],
              ),
            ),
          ),
        ],
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
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 350),
    pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
    transitionBuilder: (context, anim1, anim2, child) {
      return const MeetOurTeamSheet();
    },
  );
}
