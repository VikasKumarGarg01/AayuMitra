import 'package:aayumitra/screens/sleepRoutine/editsleep.dart';
import 'package:flutter/material.dart';

class SleepRoutinePage extends StatelessWidget {
  const SleepRoutinePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Example sleep data for the week (hours of sleep per day)
    final sleepData = {
      'Mon': 7,
      'Tue': 6,
      'Wed': 8,
      'Thu': 5,
      'Fri': 7,
      'Sat': 9,
      'Sun': 6,
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleep Routine'),
        // backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Weekly Sleep Cycle',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Weekly Sleep Chart
            SizedBox(
              height: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: sleepData.entries.map((entry) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${entry.value}h',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: entry.value * 20.0, // Scale bar height
                        width: 30,
                        decoration: BoxDecoration(
                          color: entry.value >= 7
                              ? Colors.teal[400]
                              : Colors.teal[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        entry.key,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Sleep Insights',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            // Sleep Insights Section
            Card(
              elevation: 4,
              color: const Color.fromARGB(253, 226, 246, 244),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Average Sleep Duration: 6.9 hours',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Recommendation: Aim for at least 7-8 hours of sleep per night for better health.',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Sleep Tips',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            // Sleep Tips Section
            Card(
              elevation: 4,
              color: const Color.fromARGB(253, 226, 246, 244),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: const [
                  ListTile(
                    leading: Icon(Icons.bedtime, color: Colors.teal),
                    title: Text('Maintain a consistent sleep schedule.'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.nightlight_round, color: Colors.teal),
                    title: Text(
                      'Avoid caffeine and heavy meals before bedtime.',
                    ),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.phone_android, color: Colors.teal),
                    title: Text('Limit screen time before sleeping.'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.self_improvement, color: Colors.teal),
                    title: Text(
                      'Practice relaxation techniques like meditation.',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to Edit Sleep Routine Page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditSleepRoutinePage(
                onSave: (newSleepData) {
                  // Handle the saved sleep data here
                  // For example, update the state or show a message
                },
              ),
            ),
          );
        },
        label: const Text('Edit Routine'),
        icon: const Icon(Icons.edit),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
