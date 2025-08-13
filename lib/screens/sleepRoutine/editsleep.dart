import 'package:flutter/material.dart';

class EditSleepRoutinePage extends StatefulWidget {
  const EditSleepRoutinePage({super.key});

  @override
  State<EditSleepRoutinePage> createState() => _EditSleepRoutinePageState();
}

class _EditSleepRoutinePageState extends State<EditSleepRoutinePage> {
  TimeOfDay? _bedtime;
  TimeOfDay? _wakeUpTime;
  Duration? _afternoonNapDuration;
  String _sleepStatus = "Unknown";

  void _pickTime(BuildContext context, bool isBedtime) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: isBedtime
          ? const TimeOfDay(hour: 22, minute: 0)
          : const TimeOfDay(hour: 6, minute: 0),
    );
    if (pickedTime != null) {
      setState(() {
        if (isBedtime) {
          _bedtime = pickedTime;
        } else {
          _wakeUpTime = pickedTime;
        }
        _calculateSleepStatus();
      });
    }
  }

  void _pickNapDuration(BuildContext context) async {
    final pickedDuration = await showModalBottomSheet<Duration>(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Select Nap Duration',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ListTile(
                  title: const Text('15 minutes'),
                  onTap: () =>
                      Navigator.pop(context, const Duration(minutes: 15)),
                ),
                ListTile(
                  title: const Text('30 minutes'),
                  onTap: () =>
                      Navigator.pop(context, const Duration(minutes: 30)),
                ),
                ListTile(
                  title: const Text('1 hour'),
                  onTap: () => Navigator.pop(context, const Duration(hours: 1)),
                ),
              ],
            ),
          ),
        );
      },
    );
    if (pickedDuration != null) {
      setState(() {
        _afternoonNapDuration = pickedDuration;
        _calculateSleepStatus();
      });
    }
  }

  void _calculateSleepStatus() {
    if (_bedtime != null && _wakeUpTime != null) {
      final bedtimeMinutes = _bedtime!.hour * 60 + _bedtime!.minute;
      final wakeUpMinutes = _wakeUpTime!.hour * 60 + _wakeUpTime!.minute;

      int totalSleepMinutes;
      if (wakeUpMinutes >= bedtimeMinutes) {
        totalSleepMinutes = wakeUpMinutes - bedtimeMinutes;
      } else {
        totalSleepMinutes = (24 * 60 - bedtimeMinutes) + wakeUpMinutes;
      }

      if (_afternoonNapDuration != null) {
        totalSleepMinutes += _afternoonNapDuration!.inMinutes;
      }

      final totalSleepHours = totalSleepMinutes / 60;

      setState(() {
        _sleepStatus = totalSleepHours >= 7
            ? "Good Sleep"
            : totalSleepHours >= 5
            ? "Average Sleep"
            : "Bad Sleep";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Sleep Routine'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Set Your Sleep Routine',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Bedtime Picker
            ListTile(
              leading: const Icon(Icons.bedtime, color: Colors.teal),
              title: Text(
                _bedtime == null
                    ? 'Select Bedtime'
                    : 'Bedtime: ${_bedtime!.format(context)}',
              ),
              onTap: () => _pickTime(context, true),
            ),
            const SizedBox(height: 16),
            // Wake-up Time Picker
            ListTile(
              leading: const Icon(Icons.wb_sunny, color: Colors.teal),
              title: Text(
                _wakeUpTime == null
                    ? 'Select Wake-up Time'
                    : 'Wake-up Time: ${_wakeUpTime!.format(context)}',
              ),
              onTap: () => _pickTime(context, false),
            ),
            const SizedBox(height: 16),
            // Afternoon Nap Picker
            ListTile(
              leading: const Icon(Icons.nightlight_round, color: Colors.teal),
              title: Text(
                _afternoonNapDuration == null
                    ? 'Add Afternoon Nap'
                    : 'Afternoon Nap: ${_afternoonNapDuration!.inMinutes} minutes',
              ),
              onTap: () => _pickNapDuration(context),
            ),
            const SizedBox(height: 24),
            // Sleep Status
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sleep Status',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _sleepStatus,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _sleepStatus == "Good Sleep"
                            ? Colors.green
                            : _sleepStatus == "Average Sleep"
                            ? Colors.orange
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Save Button
            ElevatedButton(
              onPressed: () {
                // Save the sleep routine
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Save Routine'),
            ),
          ],
        ),
      ),
    );
  }
}
// class EditSleepRoutinePage extends StatelessWidget {
//   const EditSleepRoutinePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Sleep Routine'),
//         backgroundColor: Colors.teal,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Set Your Sleep Routine',
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               decoration: const InputDecoration(
//                 labelText: 'Bedtime',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.bedtime),
//               ),
//               onTap: () {
//                 // Show time picker for bedtime
//               },
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               decoration: const InputDecoration(
//                 labelText: 'Wake-up Time',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.wb_sunny),
//               ),
//               onTap: () {
//                 // Show time picker for wake-up time
//               },
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 // Save the sleep routine
//                 Navigator.pop(context);
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.teal,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: const Text('Save Routine'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
