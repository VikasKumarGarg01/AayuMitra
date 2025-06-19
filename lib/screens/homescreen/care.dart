import 'package:flutter/material.dart';

class CareDashboard extends StatelessWidget {
  const CareDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'title': 'Day Care', 'icon': Icons.child_care},
      {'title': 'Professional Care', 'icon': Icons.medical_services},
      {'title': 'Nursing Care', 'icon': Icons.health_and_safety},
      {'title': 'Family Care', 'icon': Icons.family_restroom},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Text("Hi, Robert! Good Morning ", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          // const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search care services...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Care Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.1,
            ),
            itemBuilder: (context, index) {
              final item = categories[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(12),
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
                    const SizedBox(height: 8),
                    Text(
                      item['title'] as String,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "UPTO 20% OFF",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("On Caregiving Services"),
                      SizedBox(height: 8),
                      ElevatedButton(onPressed: null, child: Text("Book Now")),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Icon(Icons.local_offer, size: 48, color: Colors.orange),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
