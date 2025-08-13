import 'package:flutter/material.dart';

class NewRoutinePage extends StatefulWidget {
  const NewRoutinePage({super.key});

  @override
  State<NewRoutinePage> createState() => _NewRoutinePageState();
}

class _NewRoutinePageState extends State<NewRoutinePage> {
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedMedia;
  String? _selectedPriority;
  TimeOfDay? _selectedTime;
  final List<String> _repeatDays = [];
  final List<String> _mediaOptions = ['Tablet', 'Syrup', 'Injection'];
  final List<String> _priorityOptions = ['High', 'Medium', 'Low'];

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _pickTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _toggleRepeatDay(String day) {
    setState(() {
      if (_repeatDays.contains(day)) {
        _repeatDays.remove(day);
      } else {
        _repeatDays.add(day);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Medication Routine')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Medication Name
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Medication Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Dosage
            TextField(
              controller: _dosageController,
              decoration: const InputDecoration(
                labelText: 'Dosage',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Media (Dropdown)
            DropdownButtonFormField<String>(
              value: _selectedMedia,
              items: _mediaOptions
                  .map(
                    (media) =>
                        DropdownMenuItem(value: media, child: Text(media)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedMedia = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Type',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Priority (Dropdown)
            DropdownButtonFormField<String>(
              value: _selectedPriority,
              items: _priorityOptions
                  .map(
                    (priority) => DropdownMenuItem(
                      value: priority,
                      child: Text(priority),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPriority = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Priority',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Timer (Time Picker)
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedTime == null
                        ? 'No Time Selected'
                        : 'Time: ${_selectedTime!.format(context)}',
                  ),
                ),
                ElevatedButton(
                  onPressed: _pickTime,
                  child: const Text('Pick Time'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Repeat Days
            const Text(
              'Repeat Days',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8,
              children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                  .map(
                    (day) => ChoiceChip(
                      label: Text(day),
                      selected: _repeatDays.contains(day),
                      onSelected: (_) => _toggleRepeatDay(day),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),

            // Description
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Save Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_nameController.text.isEmpty ||
                      _dosageController.text.isEmpty ||
                      _selectedMedia == null ||
                      _selectedPriority == null ||
                      _selectedTime == null ||
                      _repeatDays.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill in all fields'),
                      ),
                    );
                    return;
                  }

                  Navigator.pop(context, {
                    'name': _nameController.text,
                    'time': _selectedTime!.format(context),
                    'repeatDays': _repeatDays,
                    'media': _selectedMedia,
                    'priority': _selectedPriority,
                    'description': _descriptionController.text,
                  });
                },
                child: const Text('Save Routine'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
