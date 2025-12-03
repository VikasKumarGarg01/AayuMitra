import 'package:flutter/material.dart';
import 'package:aayumitra/services/glass_widgets.dart';

class NotificationsTab extends StatefulWidget {
  const NotificationsTab({super.key});

  @override
  State<NotificationsTab> createState() => _NotificationsTabState();
}

class _NotificationsTabState extends State<NotificationsTab> {
  List<Map<String, dynamic>> notifications = [
    {
      'title': 'Alert: High Heart Rate',
      'read': false,
      'category': 'Emergency',
      'time': '2m ago',
    },
    {
      'title': 'Medicine Reminder',
      'read': true,
      'category': 'Reminder',
      'time': '1h ago',
    },
    {
      'title': 'Device Connected',
      'read': false,
      'category': 'Device',
      'time': 'Yesterday',
    },
  ];

  void _markAllRead() {
    setState(() {
      for (final n in notifications) n['read'] = true;
    });
  }

  Color _categoryColor(BuildContext context, String category) {
    final cs = Theme.of(context).colorScheme;
    switch (category) {
      case 'Emergency':
        return Colors.redAccent;
      case 'Reminder':
        return cs.primary;
      case 'Device':
      default:
        return Colors.orangeAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Notifications',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      )),
              const Spacer(),
              GlassButton(
                onPressed: _markAllRead,
                child: const Text('Mark all read'),
                opacity: isDark ? 0.18 : 0.22,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              itemCount: notifications.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final n = notifications[index];
                final Color tag = _categoryColor(context, n['category']);
                return GlassCard(
                  blur: 18,
                  opacity: isDark ? 0.08 : 0.16,
                  borderOpacity: 0.28,
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: tag.withOpacity(0.2),
                      child: Icon(
                        n['read'] ? Icons.notifications_none : Icons.notifications,
                        color: tag,
                      ),
                    ),
                    title: Text(
                      n['title'],
                      style: TextStyle(
                        fontWeight: n['read'] ? FontWeight.w500 : FontWeight.w700,
                      ),
                    ),
                    subtitle: Text('${n['category']} • ${n['time']}'),
                    trailing: n['read']
                        ? const SizedBox.shrink()
                        : Icon(Icons.brightness_1, color: tag, size: 10),
                    onTap: () {
                      setState(() => n['read'] = true);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
