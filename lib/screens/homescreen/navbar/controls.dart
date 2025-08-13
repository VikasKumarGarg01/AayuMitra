import 'package:aayumitra/screens/sleepRoutine/routine.dart';
import 'package:flutter/material.dart';

class Controlboard extends StatefulWidget {
  const Controlboard({super.key});

  @override
  State<Controlboard> createState() => _ControlboardState();
}

class _ControlboardState extends State<Controlboard> {
  bool _showWarning = true;

  void _navigateToEditRoutine(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RoutinePage()),
    );
  }

  void _leaveMessage(BuildContext context) {
    final TextEditingController messageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Leave a Message'),
          content: TextField(
            controller: messageController,
            decoration: const InputDecoration(
              hintText: 'Type your message here...',
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
                final message = messageController.text.trim();
                if (message.isNotEmpty) {
                  // Add the message to the conversation history
                  // Replace this with your logic to update the conversation history
                  print('Message added to conversation history: $message');
                }
                Navigator.pop(context);
              },
              child: const Text('Send'),
            ),
          ],
        );
      },
    );
  }

  void _addReminder(BuildContext context) {
    final TextEditingController labelController = TextEditingController();
    final TextEditingController detailsController = TextEditingController();
    DateTime? selectedDate;
    TimeOfDay? selectedTime;
    String selectedPriority = 'Normal';
    final List<String> priorities = ['Low', 'Normal', 'High'];

    void _pickDate() async {
      final pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
      );
      if (pickedDate != null) {
        setState(() {
          selectedDate = pickedDate;
        });
      }
    }

    void _pickTime() async {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: const TimeOfDay(hour: 8, minute: 0),
      );
      if (pickedTime != null) {
        setState(() {
          selectedTime = pickedTime;
        });
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Reminder'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: labelController,
                  decoration: const InputDecoration(
                    labelText: 'Label',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: detailsController,
                  decoration: const InputDecoration(
                    labelText: 'Details (Optional)',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: _pickDate,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            selectedDate == null
                                ? 'Select Date'
                                : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: _pickTime,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            selectedTime == null
                                ? 'Select Time'
                                : selectedTime!.format(context),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Priority',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: priorities.map((priority) {
                    return ChoiceChip(
                      label: Text(priority),
                      selected: selectedPriority == priority,
                      onSelected: (isSelected) {
                        if (isSelected) {
                          setState(() {
                            selectedPriority = priority;
                          });
                        }
                      },
                    );
                  }).toList(),
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
                if (labelController.text.trim().isNotEmpty &&
                    selectedDate != null &&
                    selectedTime != null) {
                  final reminder = {
                    'label': labelController.text.trim(),
                    'details': detailsController.text.trim(),
                    'date': selectedDate,
                    'time': selectedTime,
                    'priority': selectedPriority,
                  };
                  // Add the reminder to your reminder list
                  // Replace this with your logic to handle reminders
                  print('Reminder added: $reminder');
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
    final categories = [
      {'title': 'Edit Routine', 'icon': Icons.edit},
      {'title': 'Leave a Message', 'icon': Icons.voice_chat},
      {'title': 'Add Reminder', 'icon': Icons.add_alert},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Controls',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          if (_showWarning)
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
                      'Please ensure you have completed all necessary health checks before proceeding with any changes to care routines!',
                      style: TextStyle(
                        color: const Color.fromARGB(127, 255, 0, 0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                      color: Color.fromARGB(127, 255, 0, 0),
                    ),
                    onPressed: () {
                      setState(() {
                        _showWarning = false;
                      });
                    },
                  ),
                ],
              ),
            ),
          const SizedBox(height: 24),
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
              return GestureDetector(
                onTap: () {
                  if (item['title'] == 'Edit Routine') {
                    _navigateToEditRoutine(context);
                  } else if (item['title'] == 'Leave a Message') {
                    _leaveMessage(context);
                  } else if (item['title'] == 'Add Reminder') {
                    _addReminder(context);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.teal[50],
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
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
        ],
      ),
    );
  }
}
