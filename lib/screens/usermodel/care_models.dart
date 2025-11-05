import 'package:flutter/foundation.dart';

class CaregiverProfile {
  final String name;
  final int age;
  final String phone;
  final String relationship; // Relationship to the elderly (e.g., son, daughter, nurse)
  final String address;

  const CaregiverProfile({
    required this.name,
    required this.age,
    required this.phone,
    required this.relationship,
    required this.address,
  });
}

class ElderlyProfile {
  final String name;
  final int age;
  final String phone;
  final String conditions; // Comma-separated health conditions (optional)
  final String address;

  const ElderlyProfile({
    required this.name,
    required this.age,
    required this.phone,
    required this.conditions,
    required this.address,
  });
}

class CareContext {
  CaregiverProfile? caregiver;
  ElderlyProfile? elderly;
  String? appId; // Firestore artifacts/{appId}
  String? piId; // user_profile doc id (device hub id)

  CareContext({this.caregiver, this.elderly, this.appId, this.piId});
}

// Global context for caregiver onboarding to map routines later
final ValueNotifier<CareContext> careContextNotifier =
    ValueNotifier<CareContext>(CareContext());
