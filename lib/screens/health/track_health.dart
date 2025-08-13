import 'package:flutter/material.dart';

class TrackHealthPage extends StatefulWidget {
  const TrackHealthPage({super.key});

  @override
  State<TrackHealthPage> createState() => _TrackHealthPageState();
}

class _TrackHealthPageState extends State<TrackHealthPage> {
  Map<String, String> recentRecord = {
    'date': '13 Aug 2025',
    'weight': '70 kg',
    'bloodPressure': '120/80 mmHg',
    'heartRate': '72 bpm',
    'temperature': '98.6°F',
  };

  List<Map<String, String>> pastRecords = [
    {
      'date': '10 Aug 2025',
      'weight': '71 kg',
      'bloodPressure': '125/85 mmHg',
      'heartRate': '75 bpm',
      'temperature': '98.7°F',
    },
    {
      'date': '5 Aug 2025',
      'weight': '70.5 kg',
      'bloodPressure': '118/78 mmHg',
      'heartRate': '70 bpm',
      'temperature': '98.5°F',
    },
  ];

  void addNewRecord(Map<String, String> newRecord) {
    setState(() {
      pastRecords.insert(0, recentRecord); // Move current record to past
      recentRecord = newRecord; // Set new record as current
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Health'),
        // backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: 'Most Recent Record'),
            const SizedBox(height: 16),
            HealthRecordCard(record: recentRecord),
            const SizedBox(height: 24),
            const SectionTitle(title: 'Past Records'),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: pastRecords.length,
                itemBuilder: (context, index) {
                  final record = pastRecords[index];
                  return HealthRecordCard(record: record);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddHealthRecordPage(onSave: addNewRecord),
            ),
          );
        },
        label: const Text('Add Record'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }
}

class AddHealthRecordPage extends StatelessWidget {
  final Function(Map<String, String>) onSave;

  const AddHealthRecordPage({required this.onSave, super.key});

  @override
  Widget build(BuildContext context) {
    final weightController = TextEditingController();
    final bloodPressureController = TextEditingController();
    final heartRateController = TextEditingController();
    final temperatureController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Health Record'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: 'Enter Health Details'),
            const SizedBox(height: 16),
            HealthInputField(
              controller: weightController,
              label: 'Weight (kg)',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            HealthInputField(
              controller: bloodPressureController,
              label: 'Blood Pressure (mmHg)',
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16),
            HealthInputField(
              controller: heartRateController,
              label: 'Heart Rate (bpm)',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            HealthInputField(
              controller: temperatureController,
              label: 'Temperature (°F)',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final newRecord = {
                  'date': DateTime.now().toString().split(
                    ' ',
                  )[0], // Current date
                  'weight': '${weightController.text} kg',
                  'bloodPressure': bloodPressureController.text,
                  'heartRate': '${heartRateController.text} bpm',
                  'temperature': '${temperatureController.text}°F',
                };
                onSave(newRecord); // Pass the new record back
                Navigator.pop(context); // Go back to the previous page
              },
              child: const Text('Save Record'),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }
}

class HealthRecordCard extends StatelessWidget {
  final Map<String, String> record;

  const HealthRecordCard({required this.record, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: const Color.fromARGB(253, 226, 246, 244),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: record.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                '${entry.key}: ${entry.value}',
                style: const TextStyle(fontSize: 16),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class HealthInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;

  const HealthInputField({
    required this.controller,
    required this.label,
    required this.keyboardType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
    );
  }
}
