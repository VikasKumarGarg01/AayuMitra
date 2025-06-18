import 'package:aayumitra/screens/homescreen/home.dart';
import 'package:aayumitra/screens/signin/userselection/bluetooh.dart';
import 'package:flutter/material.dart';
// import 'bluetooth_page.dart';

class UserRolePage extends StatefulWidget {
  const UserRolePage({super.key});

  @override
  State<UserRolePage> createState() => _UserRolePageState();
}

class _UserRolePageState extends State<UserRolePage> {
  String? _selectedRole;
  final List<String> _careOptions = [
    'Professional Care',
    'Day Care',
    'Family Care',
    'Nursing Care',
  ];
  final List<String> _addedOptions = [];

  void _toggleCareOption(String option) {
    setState(() {
      if (_addedOptions.contains(option)) {
        _addedOptions.remove(option);
      } else if (_addedOptions.length < 3) {
        _addedOptions.add(option);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isCaregiver = _selectedRole == 'Caregiver';
    final canContinue =
        _selectedRole == 'Senior' ||
        (_selectedRole == 'Caregiver' && _addedOptions.length >= 3);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Who is using the app?'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select your role',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _RoleOption(
                  label: 'Senior',
                  icon: Icons.elderly,
                  selected: _selectedRole == 'Senior',
                  onTap: () => setState(() {
                    _selectedRole = 'Senior';
                    _addedOptions.clear();
                  }),
                ),
                const SizedBox(width: 32),
                _RoleOption(
                  label: 'Caregiver',
                  icon: Icons.volunteer_activism,
                  selected: _selectedRole == 'Caregiver',
                  onTap: () => setState(() {
                    _selectedRole = 'Caregiver';
                    _addedOptions.clear();
                  }),
                ),
              ],
            ),
            if (isCaregiver) ...[
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.teal),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select at least 3 care options:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: _careOptions.map((option) {
                        final added = _addedOptions.contains(option);
                        return ElevatedButton.icon(
                          icon: Icon(
                            added
                                ? Icons.check_circle
                                : Icons.add_circle_outline,
                            color: added ? Colors.green : Colors.teal,
                          ),
                          label: Text(option),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: added
                                ? Colors.green[50]
                                : Colors.white,
                            foregroundColor: Colors.teal,
                            side: BorderSide(
                              color: added ? Colors.green : Colors.teal,
                            ),
                          ),
                          onPressed: () => _toggleCareOption(option),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Selected: ${_addedOptions.length}/3',
                      style: TextStyle(
                        color: _addedOptions.length >= 3
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: canContinue
                  ? () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BluetoothPage(),
                        ),
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
            radius: selected ? 38 : 32,
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
