import 'package:flutter/material.dart';
import 'package:aayumitra/screens/medicationroutine/newroutine.dart';

class MedicationRoutinePage extends StatefulWidget {
  const MedicationRoutinePage({super.key});

  @override
  State<MedicationRoutinePage> createState() => _MedicationRoutinePageState();
}

class _MedicationRoutinePageState extends State<MedicationRoutinePage> {
  List<Map<String, dynamic>> medicationHistory = [
    {
      'name': 'Paracetamol',
      'category': 'Pill',
      'amount': '2 pills',
      'timeSlots': ['Morning', 'Evening'],
      'repeatDays': ['Monday', 'Wednesday'],
      'date': '12 Aug 2025',
    },
    {
      'name': 'Vitamin D',
      'category': 'Syrup',
      'amount': '2 tablespoons',
      'timeSlots': ['Morning'],
      'repeatDays': ['Daily'],
      'date': '11 Aug 2025',
    },
  ];

  void addNewMedication(Map<String, dynamic> newMedication) {
    setState(() {
      medicationHistory.insert(0, newMedication); // Add to history
    });
  }

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
          ...medicationHistory.map((medication) {
            return Card(
              color: const Color.fromARGB(253, 226, 246, 244),
              margin: const EdgeInsets.all(8),
              child: ListTile(
                title: Text(
                  medication['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                subtitle: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  margin: EdgeInsets.all(5),
                  padding: const EdgeInsets.all(15),
                  child: Table(
                    columnWidths: const {
                      0: IntrinsicColumnWidth(), // Adjusts the width of the first column
                      1: FlexColumnWidth(), // Expands the second column
                    },
                    children: [
                      TableRow(
                        children: [
                          const Text(
                            'Category:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(medication['category']),
                        ],
                      ),
                      const TableRow(
                        children: [
                          SizedBox(height: 8), // Add spacing between rows
                          SizedBox(height: 8),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Text(
                            'Amount:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(medication['amount']),
                        ],
                      ),
                      const TableRow(
                        children: [SizedBox(height: 8), SizedBox(height: 8)],
                      ),
                      TableRow(
                        children: [
                          const Text(
                            'Time Slots:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(medication['timeSlots'].join(', ')),
                        ],
                      ),
                      const TableRow(
                        children: [SizedBox(height: 8), SizedBox(height: 8)],
                      ),
                      TableRow(
                        children: [
                          const Text(
                            'Repeat Days:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(medication['repeatDays'].join(', ')),
                        ],
                      ),
                      const TableRow(
                        children: [SizedBox(height: 8), SizedBox(height: 8)],
                      ),
                      TableRow(
                        children: [
                          const Text(
                            'Added on:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(medication['date']),
                        ],
                      ),
                    ],
                  ),
                ),
                isThreeLine: true,
                trailing: const Icon(Icons.check_circle, color: Colors.teal),
              ),
            );
          }).toList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewRoutinePage(onSave: addNewMedication),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
