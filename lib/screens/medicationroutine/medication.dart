import 'package:flutter/material.dart';
import 'package:aayumitra/screens/medicationroutine/newroutine.dart';
import 'package:aayumitra/services/firestore_service.dart';
import 'package:aayumitra/screens/usermodel/care_models.dart';

class MedicationRoutinePage extends StatefulWidget {
  const MedicationRoutinePage({super.key});

  @override
  State<MedicationRoutinePage> createState() => _MedicationRoutinePageState();
}

class _MedicationRoutinePageState extends State<MedicationRoutinePage> {
  void addNewMedication(Map<String, dynamic> newMedication) {
    // No local state; stream below reflects new data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medication Routine')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Medication History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: careContextNotifier,
                builder: (context, ctx, _) {
                  final appId = ctx.appId ?? 'aayu-mitra-app';
                  final piId = ctx.piId ?? 'pi-hub-001';
          final query = FirestoreService.instance
            .collection(appId, 'medication')
            .where('pi_id', isEqualTo: piId);
                  return StreamBuilder(
                    stream: query.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      final docsRaw = snapshot.data?.docs ?? [];
                      // Sort client-side by created_at desc to avoid requiring a composite index
                      final docs = [...docsRaw]..sort((a, b) {
                          final aTs = (a.data()['created_at'] ?? '') as String;
                          final bTs = (b.data()['created_at'] ?? '') as String;
                          return bTs.compareTo(aTs);
                        });
                      if (docs.isEmpty) {
                        return const Center(
                          child: Text('No medications added yet.'),
                        );
                      }
                      return ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          final data = docs[index].data();
                          final title = data['title'] ?? '';
                          final category = data['category'] ?? '';
                          final amount = data['amount'] ?? '';
                          final timeSlots = (data['time_slots'] as List?)
                                  ?.cast<String>() ??
                              const [];
                          final repeatDays = (data['repeat_days'] as List?)
                                  ?.cast<String>() ??
                              const [];
                          return Card(
                            color: const Color.fromARGB(253, 226, 246, 244),
                            margin: const EdgeInsets.all(8),
                            child: ListTile(
                              title: Text(
                                title,
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
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.all(15),
                                child: Table(
                                  columnWidths: const {
                                    0: IntrinsicColumnWidth(),
                                    1: FlexColumnWidth(),
                                  },
                                  children: [
                                    TableRow(children: [
                                      const Text('Category:',
                                          style: TextStyle(fontWeight: FontWeight.bold)),
                                      Text(category),
                                    ]),
                                    const TableRow(children: [
                                      SizedBox(height: 8),
                                      SizedBox(height: 8),
                                    ]),
                                    TableRow(children: [
                                      const Text('Amount:',
                                          style: TextStyle(fontWeight: FontWeight.bold)),
                                      Text(amount),
                                    ]),
                                    const TableRow(children: [
                                      SizedBox(height: 8),
                                      SizedBox(height: 8),
                                    ]),
                                    TableRow(children: [
                                      const Text('Time Slots:',
                                          style: TextStyle(fontWeight: FontWeight.bold)),
                                      Text(timeSlots.join(', ')),
                                    ]),
                                    const TableRow(children: [
                                      SizedBox(height: 8),
                                      SizedBox(height: 8),
                                    ]),
                                    TableRow(children: [
                                      const Text('Repeat Days:',
                                          style: TextStyle(fontWeight: FontWeight.bold)),
                                      Text(repeatDays.join(', ')),
                                    ]),
                                  ],
                                ),
                              ),
                              isThreeLine: true,
                              trailing:
                                  const Icon(Icons.check_circle, color: Colors.teal),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
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
