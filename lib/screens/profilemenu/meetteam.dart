import 'package:aayumitra/screens/profilemenu/animatedside.dart';
import 'package:flutter/material.dart';
// import 'animated_side_sheet.dart';

class MeetOurTeamSheet extends StatelessWidget {
  const MeetOurTeamSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final team = [
      {
        'name': 'Person 1',
        'email': 'person1@aayumitra.com',
        'phone': '+91 90000 00001',
        'role': 'Lead Developer',
        'img': 'assets/images/profile.png',
      },
      {
        'name': 'Person 2',
        'email': 'person2@aayumitra.com',
        'phone': '+91 90000 00002',
        'role': 'UI/UX Designer',
        'img': 'assets/images/profile.png',
      },
      {
        'name': 'Person 3',
        'email': 'person3@aayumitra.com',
        'phone': '+91 90000 00003',
        'role': 'Backend Engineer',
        'img': 'assets/images/profile.png',
      },
      {
        'name': 'Person 4',
        'email': 'person4@aayumitra.com',
        'phone': '+91 90000 00004',
        'role': 'QA Specialist',
        'img': 'assets/images/profile.png',
      },
      {
        'name': 'Person 5',
        'email': 'person5@aayumitra.com',
        'phone': '+91 90000 00005',
        'role': 'Free Specialist',
        'img': 'assets/images/profile.png',
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
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 350),
    pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
    transitionBuilder: (context, anim1, anim2, child) {
      return const MeetOurTeamSheet();
    },
  );
}
