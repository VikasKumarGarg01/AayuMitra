// import 'package:aayumitra/screens/homescreen/navbar/offer.dart';
import 'package:aayumitra/screens/health/track_health.dart';
import 'package:aayumitra/screens/medicationroutine/medication.dart';
import 'package:aayumitra/screens/sleepRoutine/sleep.dart'; // Import SleepRoutinePage
// import 'package:aayumitra/screens/medicationroutine/medication.dart';
import 'package:flutter/material.dart';

// import 'package:aayumitra/screens/medicationroutine/medication_routine.dart'; // Import the Medication Routine page
// AayuMitra\lib\screens\medicationroutine\medication.dart
class CareDashboard extends StatelessWidget {
  const CareDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'title': 'Medication Routine', 'icon': Icons.medication},
      {'title': 'Sleep Routine', 'icon': Icons.bedtime},
      {'title': 'Conversation History', 'icon': Icons.message},
      {'title': 'Track Health', 'icon': Icons.health_and_safety},
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
          //     hintText: 'Search care services...',
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
            'Care Categories',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          // Container(
          //   width: double.infinity,
          //   padding: const EdgeInsets.all(15),
          //   decoration: BoxDecoration(
          //     color: Colors.teal[50],
          //     borderRadius: BorderRadius.circular(25),
          //   ),
          //   child: const OfferCarousel(),
          // ),
          // const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 25,
              crossAxisSpacing: 25,
              childAspectRatio: 1.1,
            ),
            itemBuilder: (context, index) {
              final item = categories[index];
              return GestureDetector(
                onTap: () {
                  if (item['title'] == 'Medication Routine') {
                    // Navigate to Medication Routine page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MedicationRoutinePage(),
                      ),
                    );
                  } else if (item['title'] == 'Sleep Routine') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SleepRoutinePage(),
                      ),
                    );
                  } else if (item['title'] == 'Track Health') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TrackHealthPage(),
                      ),
                    );
                  }
                },
                child: Container(
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
                ),
              );
            },
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
