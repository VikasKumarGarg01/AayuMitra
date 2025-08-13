import 'package:flutter/material.dart';

class RoutinePage extends StatefulWidget {
  const RoutinePage({super.key});

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  final List<Map<String, dynamic>> _routineHistory = [
    {
      'name': 'Morning Walk',
      'time': '6:00 AM',
      'days': ['Monday', 'Wednesday', 'Friday'],
      'notes': 'Walk for 30 minutes in the park.',
    },
    {
      'name': 'Evening Yoga',
      'time': '7:00 PM',
      'days': ['Tuesday', 'Thursday'],
      'notes': 'Yoga session for relaxation.',
    },
  ];

  void _addNewRoutine(Map<String, dynamic> newRoutine) {
    setState(() {
      _routineHistory.insert(0, newRoutine); // Add the new routine to the top
    });
  }

  void _showAddRoutineDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController timeController = TextEditingController();
    final TextEditingController notesController = TextEditingController();
    final List<String> selectedDays = [];
    final List<String> daysOfWeek = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Routine'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Routine Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: timeController,
                  decoration: const InputDecoration(
                    labelText: 'Time (e.g., 6:00 AM)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Select Days',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Wrap(
                  spacing: 8,
                  children: daysOfWeek.map((day) {
                    return FilterChip(
                      label: Text(day),
                      selected: selectedDays.contains(day),
                      onSelected: (isSelected) {
                        setState(() {
                          if (isSelected) {
                            selectedDays.add(day);
                          } else {
                            selectedDays.remove(day);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: notesController,
                  decoration: const InputDecoration(
                    labelText: 'Notes (Optional)',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newRoutine = {
                  'name': nameController.text.trim(),
                  'time': timeController.text.trim(),
                  'days': selectedDays,
                  'notes': notesController.text.trim(),
                };
                if ((newRoutine['name'] as String).isNotEmpty &&
                    (newRoutine['time'] as String).isNotEmpty &&
                    selectedDays.isNotEmpty) {
                  _addNewRoutine(newRoutine);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routine Page'),
        // backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _routineHistory.length,
        itemBuilder: (context, index) {
          final routine = _routineHistory[index];
          return Card(
            color: Colors.teal[50],
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(
                routine['name'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Time: ${routine['time']}'),
                  Text('Days: ${routine['days'].join(', ')}'),
                  if (routine['notes'] != null && routine['notes']!.isNotEmpty)
                    Text('Notes: ${routine['notes']}'),
                ],
              ),
              isThreeLine: true,
              trailing: const Icon(Icons.check_circle, color: Colors.teal),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddRoutineDialog,
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
