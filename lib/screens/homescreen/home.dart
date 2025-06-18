import 'package:aayumitra/screens/settings/profile.dart';
import 'package:flutter/material.dart';
// import 'settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    Center(child: Text('Highlights', style: TextStyle(fontSize: 24))),
    Center(child: Text('Controls', style: TextStyle(fontSize: 24))),
    Center(child: Text('Emergency Alerts', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _openProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProfileScreen()),
    );
  }

  void _openNotifications(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NotificationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => _openProfile(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/profile.jpg',
              ), // Replace with your asset
            ),
          ),
        ),
        title: const Text('AayuMitra'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () => _openNotifications(context),
          ),
        ],
        elevation: 0,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.all(_selectedIndex == 0 ? 8 : 0),
              child: Icon(
                Icons.star,
                size: _selectedIndex == 0 ? 32 : 24,
                color: _selectedIndex == 0 ? Colors.teal : Colors.grey,
              ),
            ),
            label: 'Highlights',
          ),
          BottomNavigationBarItem(
            icon: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.all(_selectedIndex == 1 ? 8 : 0),
              child: Icon(
                Icons.settings_remote,
                size: _selectedIndex == 1 ? 32 : 24,
                color: _selectedIndex == 1 ? Colors.teal : Colors.grey,
              ),
            ),
            label: 'Controls',
          ),
          BottomNavigationBarItem(
            icon: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.all(_selectedIndex == 2 ? 8 : 0),
              child: Icon(
                Icons.warning,
                size: _selectedIndex == 2 ? 32 : 24,
                color: _selectedIndex == 2 ? Colors.teal : Colors.grey,
              ),
            ),
            label: 'Alerts',
          ),
        ],
      ),
    );
  }
}

// Notification Screen (UI only)
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample notifications
    final notifications = [
      {
        'title': 'Alert: High Heart Rate',
        'read': false,
        'category': 'Emergency',
      },
      {'title': 'Medicine Reminder', 'read': true, 'category': 'Reminder'},
      {'title': 'Device Connected', 'read': false, 'category': 'Device'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Mark all read',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Unread',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ...notifications
              .where((n) => n['read'] == false)
              .map(
                (n) => ListTile(
                  leading: Icon(Icons.notifications, color: Colors.teal),
                  title: Text(n['title'] as String),
                  subtitle: Text(n['category'] as String),
                  trailing: Icon(Icons.circle, color: Colors.red, size: 12),
                ),
              ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Read', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ...notifications
              .where((n) => n['read'] == true)
              .map(
                (n) => ListTile(
                  leading: Icon(Icons.notifications_none, color: Colors.grey),
                  title: Text(n['title'] as String),
                  subtitle: Text(n['category'] as String),
                ),
              ),
        ],
      ),
    );
  }
}
