// Notification Screen (UI only)
import 'package:flutter/material.dart';
// import 'care.dart'
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