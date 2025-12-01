// import 'package:aayumitra/screens/homescreen/navbar/offer.dart';
import 'package:flutter/material.dart';
import 'package:aayumitra/screens/conversation/conversation.dart';
import 'package:aayumitra/screens/health/track_health.dart';
import 'package:aayumitra/screens/medicationroutine/medication.dart';
import 'package:aayumitra/screens/sleepRoutine/sleep.dart'; // Import SleepRoutinePage
import 'package:aayumitra/services/glass_widgets.dart';
// import 'package:aayumitra/screens/medicationroutine/medication.dart';
class CareDashboard extends StatelessWidget {
  const CareDashboard({super.key});

  void _open(BuildContext context, String title) {
    Widget page;
    switch (title) {
      case 'Medication Routine':
        page = const MedicationRoutinePage();
        break;
      case 'Sleep Routine':
        page = const SleepRoutinePage();
        break;
      case 'Track Health':
        page = const TrackHealthPage();
        break;
      case 'Conversation History':
      default:
        page = const ConversationPage();
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cs = Theme.of(context).colorScheme;
    final cards = [
      {
        'title': 'Medication Routine',
        'subtitle': 'View & manage timings',
        'icon': Icons.medication,
        'color': cs.primary.withOpacity(0.12),
      },
      {
        'title': 'Sleep Routine',
        'subtitle': 'Track rest patterns',
        'icon': Icons.bedtime,
        'color': cs.primary.withOpacity(0.12),
      },
      {
        'title': 'Conversation History',
        'subtitle': 'Review past messages',
        'icon': Icons.message,
        'color': cs.primary.withOpacity(0.12),
      },
      {
        'title': 'Track Health',
        'subtitle': 'Vitals & progress',
        'icon': Icons.health_and_safety,
        'color': cs.primary.withOpacity(0.12),
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Care Categories',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 16),
          // Staggered vertical cards with gradients
          Column(
            children: [
              for (int i = 0; i < cards.length; i++) ...[
                _CategoryCard(
                  title: cards[i]['title'] as String,
                  subtitle: cards[i]['subtitle'] as String,
                  icon: cards[i]['icon'] as IconData,
                  bgColor: cards[i]['color'] as Color,
                  accent: cs.primary,
                  dark: isDark,
                  onTap: () => _open(context, cards[i]['title'] as String),
                ),
                const SizedBox(height: 18),
              ]
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color bgColor;
  final Color accent;
  final bool dark;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.bgColor,
    required this.accent,
    required this.dark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: GlassCard(
        blur: 14,
        opacity: dark ? 0.08 : 0.14,
        borderOpacity: 0.30,
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        accentBorder: accent.withOpacity(0.4),
        child: Row(
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: accent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(icon, size: 30, color: accent),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: dark ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: dark ? Colors.white70 : Colors.grey[700],
                        ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: accent, size: 26),
          ],
        ),
      ),
    );
  }
}
