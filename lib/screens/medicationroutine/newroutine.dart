import 'package:flutter/material.dart';
import 'package:aayumitra/screens/usermodel/care_models.dart';
import 'package:aayumitra/services/firestore_service.dart';

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
              initialValue: selectedCategory,
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
              onPressed: () async {
                final title = nameController.text.trim();
                final amountText = amountController.text.trim();
                if (title.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter medication name')),
                  );
                  return;
                }
                if (amountText.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter amount')),
                  );
                  return;
                }
                try {
                  final ctx = careContextNotifier.value;
                  final appId = ctx.appId ?? 'aayu-mitra-app';
                  final piId = ctx.piId ?? 'pi-hub-001';

                  final newMedication = {
                    'piId': piId,
                    'title': title,
                    'category': selectedCategory,
                    'amount': selectedCategory == 'Syrup'
                        ? '$amountText tablespoons'
                        : '$amountText pills',
                    'time_slots': selectedTimeSlots, // array<string>
                    'repeat_days': selectedRepeatDays, // array<string>
                    'created_at': DateTime.now().toIso8601String(),
                  };

                  await FirestoreService.instance.addMedication(
                    appId: appId,
                    piId: piId,
                    medication: newMedication,
                  );

                  widget.onSave(newMedication); // Update local UI
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to save: $e')),
                  );
                }
              },
              child: const Text('Save Medication'),
            ),
          ],
        ),
      ),
    );
  }
}
