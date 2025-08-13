import 'package:flutter/material.dart';

class Controlboard extends StatelessWidget {
  const Controlboard({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'title': 'Edit Routine', 'icon': Icons.edit},
      {'title': 'Leave a Message', 'icon': Icons.voice_chat},
      {'title': 'Add Reminder', 'icon': Icons.add_alert},
      // {'title': 'Track Health', 'icon': Icons.health_and_safety},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Text("Hi, Robert! Good Morning ", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          // const SizedBox(height: 16),
          // TextField(
          //   decoration: InputDecoration(
          //     hintText: 'Search control services...',
          //     prefixIcon: const Icon(Icons.search),
          //     filled: true,
          //     fillColor: Colors.grey[200],
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(12),
          //       borderSide: BorderSide.none,
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 24),
          const Text(
            'Controls',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(207, 252, 223, 223),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning,
                  size: 36,
                  color: const Color.fromARGB(127, 255, 0, 0),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Please ensure you have completed all necessary health checks before proceeding with any changes care routines !',
                    style: TextStyle(
                      color: const Color.fromARGB(127, 255, 0, 0),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.close,
                  size: 20,
                  color: const Color.fromARGB(127, 255, 0, 0),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 25,
              crossAxisSpacing: 25,
              childAspectRatio: 2,
            ),
            itemBuilder: (context, index) {
              final item = categories[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item['icon'] as IconData,
                      size: 36,
                      color: Colors.teal,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      item['title'] as String,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
