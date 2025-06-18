import 'package:aayumitra/screens/homescreen/home.dart';
import 'package:flutter/material.dart';

class UserRolePage extends StatefulWidget {
  const UserRolePage({super.key});

  @override
  State<UserRolePage> createState() => _UserRolePageState();
}

class _UserRolePageState extends State<UserRolePage> {
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Who is using the app?'),
        // automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'I am a...',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            const Text(
              'Select your role',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _RoleOption(
                  label: 'Senior',
                  icon: Icons.elderly,
                  selected: _selectedRole == 'Senior',
                  onTap: () => setState(() => _selectedRole = 'Senior'),
                ),
                const SizedBox(width: 40),
                _RoleOption(
                  label: 'Caregiver',
                  icon: Icons.volunteer_activism,
                  selected: _selectedRole == 'Caregiver',
                  onTap: () => setState(() => _selectedRole = 'Caregiver'),
                ),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _selectedRole != null
                  ? () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                        (route) => false,
                      );
                    }
                  : null,
              child: const Text("Let's Go"),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _RoleOption({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: selected ? 60 : 40,
            backgroundColor: selected ? Colors.teal : Colors.grey[300],
            child: Icon(
              icon,
              size: 40,
              color: selected ? Colors.white : Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selected ? Colors.teal : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
