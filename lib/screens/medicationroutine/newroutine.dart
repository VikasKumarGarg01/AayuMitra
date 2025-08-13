import 'package:flutter/material.dart';

class NewRoutinePage extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;

  const NewRoutinePage({required this.onSave, super.key});

  @override
  State<NewRoutinePage> createState() => _NewRoutinePageState();
}

class _NewRoutinePageState extends State<NewRoutinePage> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  String selectedCategory = 'Pill';
  List<String> selectedTimeSlots = [];
  List<String> selectedRepeatDays = [];

  final List<String> categories = ['Pill', 'Syrup'];
  final List<String> timeSlots = ['Morning', 'Afternoon', 'Evening', 'Night'];
  final List<String> repeatDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
    'Daily',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Medication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Medication Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: categories
                  .map(
                    (category) => DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                  amountController
                      .clear(); // Clear amount when category changes
                });
              },
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: selectedCategory == 'Syrup'
                    ? 'Amount (tablespoons)'
                    : 'Amount (pills)',
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            const Text(
              'Select Time Slots',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8,
              children: timeSlots.map((slot) {
                return FilterChip(
                  label: Text(slot),
                  selected: selectedTimeSlots.contains(slot),
                  onSelected: (isSelected) {
                    setState(() {
                      if (isSelected) {
                        selectedTimeSlots.add(slot);
                      } else {
                        selectedTimeSlots.remove(slot);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text(
              'Select Repeat Days',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8,
              children: repeatDays.map((day) {
                return FilterChip(
                  label: Text(day),
                  selected: selectedRepeatDays.contains(day),
                  onSelected: (isSelected) {
                    setState(() {
                      if (isSelected) {
                        selectedRepeatDays.add(day);
                      } else {
                        selectedRepeatDays.remove(day);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final newMedication = {
                  'name': nameController.text,
                  'category': selectedCategory,
                  'amount': selectedCategory == 'Syrup'
                      ? '${amountController.text} tablespoons'
                      : '${amountController.text} pills',
                  'timeSlots': selectedTimeSlots,
                  'repeatDays': selectedRepeatDays,
                  'date': DateTime.now().toString().split(' ')[0],
                };
                widget.onSave(newMedication); // Pass the new medication back
                Navigator.pop(context); // Go back to the previous page
              },
              child: const Text('Save Medication'),
            ),
          ],
        ),
      ),
    );
  }
}
