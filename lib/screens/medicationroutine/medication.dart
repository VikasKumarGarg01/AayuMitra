import 'package:aayumitra/screens/medicationroutine/newroutine.dart';
import 'package:flutter/material.dart';

class MedicationRoutinePage extends StatelessWidget {
  const MedicationRoutinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medication Routine')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Medication History',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          // Example medication history items
          ListTile(
            title: const Text('Paracetamol'),
            subtitle: const Text('Taken on: 12 Aug 2025'),
            trailing: const Icon(Icons.check_circle, color: Colors.green),
          ),
          ListTile(
            title: const Text('Vitamin D'),
            subtitle: const Text('Taken on: 11 Aug 2025'),
            trailing: const Icon(Icons.check_circle, color: Colors.green),
          ),
          const SizedBox(height: 24),
          const Text(
            'Upcoming Tasks',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          // Example upcoming tasks
          ListTile(
            title: const Text('Ibuprofen'),
            subtitle: const Text('Scheduled for: 14 Aug 2025'),
            trailing: const Icon(Icons.schedule, color: Colors.orange),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the New Medication Routine page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewRoutinePage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
