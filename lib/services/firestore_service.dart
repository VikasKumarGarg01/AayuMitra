import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Build a collection path under the data root
  CollectionReference<Map<String, dynamic>> collection(
    String appId,
    String name,
  ) {
    return _db
        .collection('artifacts')
        .doc(appId)
        .collection('public')
        .doc('data')
        .collection(name);
  }

  // 1) user_profile: /user_profile/{pi_id}
  Future<void> upsertUserProfile({
    required String appId,
    required String piId,
    required Map<String, dynamic> data,
  }) async {
    final col = collection(appId, 'user_profile');
    await col.doc(piId).set(data, SetOptions(merge: true));
  }

  // 2) medication
  Future<String> addMedication({
    required String appId,
    required Map<String, dynamic> medication,
  }) async {
    final col = collection(appId, 'medication');
    final doc = await col.add(medication);
    return doc.id;
  }

  // 3) routines
  Future<String> addRoutine({
    required String appId,
    required Map<String, dynamic> routine,
  }) async {
    final col = collection(appId, 'routines');
    final doc = await col.add(routine);
    return doc.id;
  }

  // 4) reminders
  Future<String> addReminder({
    required String appId,
    required Map<String, dynamic> reminder,
  }) async {
    final col = collection(appId, 'reminders');
    final doc = await col.add(reminder);
    return doc.id;
  }

  // 5) health_records
  Future<String> addHealthRecord({
    required String appId,
    required Map<String, dynamic> record,
  }) async {
    final col = collection(appId, 'health_records');
    final doc = await col.add(record);
    return doc.id;
  }

  // 6) sleep_logs
  Future<String> addSleepLog({
    required String appId,
    required Map<String, dynamic> log,
  }) async {
    final col = collection(appId, 'sleep_logs');
    final doc = await col.add(log);
    return doc.id;
  }

  // 7) alerts
  Future<String> addAlert({
    required String appId,
    required Map<String, dynamic> alert,
  }) async {
    final col = collection(appId, 'alerts');
    final doc = await col.add(alert);
    return doc.id;
  }

  // 8) messages
  Future<String> addMessage({
    required String appId,
    required Map<String, dynamic> message,
  }) async {
    final col = collection(appId, 'messages');
    final doc = await col.add(message);
    return doc.id;
  }
}
