import 'package:aayumitra/screens/homescreen/navbar/controls.dart';
import 'package:aayumitra/screens/homescreen/notification.dart';
// import 'package:aayumitra/screens/usermodel/userdata.dart';
import 'package:flutter/material.dart';
import 'package:aayumitra/screens/homescreen/navbar/highlight.dart';
import 'package:aayumitra/services/glass_widgets.dart';
// import 'package:aayumitra/screens/homescreen/navbar/emergency.dart';
// import 'package:aayumitra/screens/profilemenu/profile.dart';
import 'package:aayumitra/screens/profilemenu/profilesheet.dart';
import 'package:aayumitra/screens/usermodel/care_models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _screens = [
    const CareDashboard(),
    const Controlboard(),
  const NotificationsTab(),
    // const EmergencyAlert(), // Emergency tab
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

  // Notifications are accessible via bottom nav; header bell removed.

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
      extendBody: true,
      body: Stack(
        children: [
          // Main content
          SafeArea(
            child: Column(
              children: [
                // Unique curved gradient + glass layered header
                _HomeHeader(
                  onProfileTap: () => _showProfileSheet(context),
                  greeting: _getGreeting(),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: _screens[_selectedIndex],
                  ),
                ),
              ],
            ),
          ),
          // Floating bottom bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 25,
            child: Center(
              child: _GlassBottomNav(
                selectedIndex: _selectedIndex,
                onTap: _onItemTapped,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  final VoidCallback onProfileTap;
  final String greeting;
  const _HomeHeader({
    required this.onProfileTap,
    required this.greeting,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;
    final isNarrow = width < 360;
    final greetingFont = isNarrow ? 24.0 : 30.0;
    final nameFont = isNarrow ? 16.0 : 18.0;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Stack(
        children: [
          // Curved gradient backdrop shape
          Container(
            // Increased height to support larger avatar without overflow
            height: isNarrow ? 188 : 208,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        Color(0xFF0F2F2F),
                        colorScheme.primary.withOpacity(0.25),
                        const Color(0xFF122424),
                      ]
                    : [
                        colorScheme.primary.withOpacity(0.10),
                        Colors.white,
                        colorScheme.primary.withOpacity(0.05),
                      ],
              ),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withOpacity(0.5)
                      : Colors.teal.withOpacity(0.08),
                  blurRadius: 28,
                  offset: const Offset(0, 14),
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          // Glass overlay card
          Positioned.fill(
            child: GlassCard(
              blur: 24,
              opacity: isDark ? 0.07 : 0.18,
              borderOpacity: 0.30,
              borderRadius: const BorderRadius.all(Radius.circular(36)),
              accentBorder: colorScheme.primary.withOpacity(isDark ? 0.35 : 0.28),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isNarrow ? 16 : 20, vertical: isNarrow ? 14 : 18),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final content = Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: onProfileTap,
                          child: _Avatar(isDark: isDark, compact: isNarrow),
                        ),
                        SizedBox(width: isNarrow ? 14 : 20),
                        Expanded(
                          child: _GreetingBlock(
                            greeting: greeting,
                            greetingFont: greetingFont,
                            nameFont: nameFont,
                          ),
                        ),
                      ],
                    );
                    return content;
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final bool isDark;
  final bool compact;
  const _Avatar({required this.isDark, this.compact = false});
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
  // Increased avatar sizes
  final outerSize = compact ? 76.0 : 92.0;
  final innerSize = compact ? 62.0 : 76.0;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: outerSize,
          height: outerSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: SweepGradient(
              colors: [
                colorScheme.primary.withOpacity(0.85),
                colorScheme.primary.withOpacity(0.3),
                colorScheme.primary.withOpacity(0.7),
                colorScheme.primary.withOpacity(0.2),
              ],
            ),
          ),
        ),
        Container(
          width: innerSize,
          height: innerSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 2.5,
              color: isDark ? Colors.white.withOpacity(0.25) : Colors.white.withOpacity(0.7),
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

class _GreetingBlock extends StatelessWidget {
  final String greeting;
  final double greetingFont;
  final double nameFont;
  const _GreetingBlock({required this.greeting, this.greetingFont = 30, this.nameFont = 18});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: careContextNotifier,
      builder: (context, ctx, _) {
        final name = ctx.caregiver?.name ?? ctx.elderly?.name ?? 'there';
        final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
      fontSize: nameFont,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.teal.shade200 : Theme.of(context).colorScheme.primary,
            );
    final greetStyle = Theme.of(context).textTheme.headlineSmall?.copyWith(
      fontSize: greetingFont,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : Colors.black87,
            );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Hi $name 👋',
              style: baseStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              // style: FontStyle.italic,
            ),
            const SizedBox(height: 4),
            ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  colors: isDark
                      ? [Colors.white, Colors.teal.shade200]
                      : [Colors.black, Theme.of(context).colorScheme.primary],
                ).createShader(bounds);
              },
              blendMode: BlendMode.srcIn,
              child: Text(
                greeting,
                style: greetStyle,
                maxLines: 2,
                overflow: TextOverflow.fade,
                softWrap: true,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _GlassBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  const _GlassBottomNav({required this.selectedIndex, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    return GlassCard(
      blur: 30,
      opacity: isDark ? 0.10 : 0.20,
      borderOpacity: 0.32,
      borderRadius: const BorderRadius.all(Radius.circular(46)),
      accentBorder: colorScheme.primary.withOpacity(0.55),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (i) {
          final data = [
            (Icons.auto_awesome, 'Highlights'),
            (Icons.tune, 'Controls'),
            (Icons.notifications, 'Alerts'),
          ];
          final isSelected = selectedIndex == i;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: InkWell(
              onTap: () => onTap(i),
              borderRadius: BorderRadius.circular(32),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutQuart,
                padding: EdgeInsets.symmetric(
                  horizontal: isSelected ? 20 : 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            colorScheme.primary.withOpacity(isDark ? 0.55 : 0.65),
                            colorScheme.primary.withOpacity(isDark ? 0.30 : 0.40),
                          ],
                        )
                      : null,
                  color: isSelected
                      ? null
                      : (isDark
                          ? Colors.white.withOpacity(0.06)
                          : Colors.white.withOpacity(0.55)),
                  border: Border.all(
                    color: isSelected
                        ? colorScheme.primary.withOpacity(0.65)
                        : (isDark
                            ? Colors.white.withOpacity(0.18)
                            : Colors.teal.withOpacity(0.25)),
                  ),
                  boxShadow: [
                    if (isSelected)
                      BoxShadow(
                        color: colorScheme.primary.withOpacity(0.5),
                        blurRadius: 18,
                        spreadRadius: 1,
                        offset: const Offset(0, 6),
                      ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      data[i].$1,
                      size: isSelected ? 26 : 22,
                      color: isSelected
                          ? (isDark ? Colors.black : Colors.white)
                          : (isDark ? Colors.teal.shade200 : Colors.black87),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 220),
                      child: isSelected
                          ? Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                data[i].$2,
                                key: ValueKey(i),
                                style: TextStyle(
                                  color: isDark ? Colors.black : Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
