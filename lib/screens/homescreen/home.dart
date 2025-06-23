import 'package:aayumitra/screens/homescreen/navbar/controls.dart';
import 'package:aayumitra/screens/homescreen/navbar/emergency.dart';
import 'package:aayumitra/screens/homescreen/notification.dart';
// import 'package:aayumitra/screens/usermodel/userdata.dart';
import 'package:flutter/material.dart';
import 'package:aayumitra/screens/homescreen/navbar/highlight.dart';
// import 'package:aayumitra/screens/homescreen/navbar/emergency.dart';
// import 'package:aayumitra/screens/profilemenu/profile.dart';
import 'package:aayumitra/screens/profilemenu/profilesheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _screens = [
    const CareDashboard(),
    const Controlboard(),
    const EmergencyAlert(), // Emergency tab
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  void _showProfileSheet(BuildContext context) {
    Navigator.of(context).push(_leftToRightRoute());
  }

  Route _leftToRightRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const ProfileSheet(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0); // from left
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 10),
      opaque: false,
      barrierDismissible: true,
      fullscreenDialog: true,
    );
  }

  void _openNotifications(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NotificationScreen()),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const ProfileSheet(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 15), // Placeholder for drawer icon
                  GestureDetector(
                    onTap: () => _showProfileSheet(context),
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/profile.png'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hi Robert 👋,',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(137, 206, 44, 44),
                          ),
                        ),
                        Text(
                          _getGreeting(),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications, size: 32),
                    onPressed: () => _openNotifications(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(child: _screens[_selectedIndex]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: List.generate(3, (i) {
          final icons = [Icons.star, Icons.settings_remote, Icons.warning];
          final labels = ['Highlights', 'Controls', 'Alerts'];
          final isSelected = _selectedIndex == i;
          return BottomNavigationBarItem(
            icon: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.all(isSelected ? 8 : 0),
              child: Icon(
                icons[i],
                size: isSelected ? 32 : 24,
                color: isSelected ? Colors.teal : Colors.grey,
              ),
            ),
            label: labels[i],
          );
        }),
      ),
    );
  }
}
