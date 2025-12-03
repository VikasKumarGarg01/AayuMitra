import 'package:aayumitra/screens/sleepRoutine/routine.dart';
import 'package:flutter/material.dart';
import 'package:aayumitra/services/glass_widgets.dart';

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
    final actions = [
      {
        'title': 'Edit Routine',
        'subtitle': 'Modify existing care schedule',
        'icon': Icons.edit,
        'onTap': () => _navigateToEditRoutine(context),
        'color': Colors.teal.shade50,
      },
      {
        'title': 'Leave a Message',
        'subtitle': 'Send a quick note to caregiver',
        'icon': Icons.voice_chat,
        'onTap': () => _leaveMessage(context),
        'color': Colors.blue.shade50,
      },
      {
        'title': 'Add Reminder',
        'subtitle': 'Schedule a new care reminder',
        'icon': Icons.add_alert,
        'onTap': () => _addReminder(context),
        'color': Colors.orange.shade50,
      },
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
            LayoutBuilder(builder: (context, constraints) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(207, 252, 223, 223),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Icon(
                        Icons.warning,
                        size: 30,
                        color: Color.fromARGB(127, 255, 0, 0),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Please ensure you have completed all necessary health checks before proceeding with any changes to care routines!',
                            style: const TextStyle(
                              fontSize: 13,
                              height: 1.3,
                              color: Color.fromARGB(127, 255, 0, 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.close,
                        size: 18,
                        color: Color.fromARGB(127, 255, 0, 0),
                      ),
                      onPressed: () => setState(() => _showWarning = false),
                    ),
                  ],
                ),
              );
            }),
          const SizedBox(height: 24),
          Column(
            children: actions.map((item) {
              final Color accent = Colors.teal;
              return InkWell(
                onTap: item['onTap'] as void Function(),
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: GlassCard(
                    blur: 14,
                    opacity: Theme.of(context).brightness == Brightness.dark ? 0.07 : 0.14,
                    borderOpacity: 0.30,
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    accentBorder: accent.withOpacity(0.4),
                    child: Row(
                      children: [
                        Container(
                          height: 56,
                          width: 56,
                          decoration: BoxDecoration(
                            color: accent.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Icon(item['icon'] as IconData, size: 30, color: accent),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'] as String,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                item['subtitle'] as String,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? Colors.grey[300]
                                      : Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right, color: accent, size: 26),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
