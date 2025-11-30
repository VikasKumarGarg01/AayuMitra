import 'package:aayumitra/screens/signin/userselection/elderly_details_page.dart';
import 'package:aayumitra/screens/usermodel/care_models.dart';
import 'package:aayumitra/services/care_context_persistence.dart';
import 'package:aayumitra/services/firestore_service.dart';
import 'package:flutter/material.dart';

class CaregiverDetailsPage extends StatefulWidget {
  const CaregiverDetailsPage({super.key});

  @override
  State<CaregiverDetailsPage> createState() => _CaregiverDetailsPageState();
}

class _CaregiverDetailsPageState extends State<CaregiverDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _age = TextEditingController();
  final _phone = TextEditingController();
  final _relationship = TextEditingController();
  final _address = TextEditingController();
  final _piId = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _age.dispose();
    _phone.dispose();
    _relationship.dispose();
    _address.dispose();
  _piId.dispose();
    super.dispose();
  }

  void _next() {
    if (!_formKey.currentState!.validate()) return;
    // Check piId uniqueness if entered
    final enteredPiId = _piId.text.trim();
    if (enteredPiId.isNotEmpty) {
      final ctx = careContextNotifier.value;
      final appId = ctx.appId ?? 'aayu-mitra-app';
      FirestoreService.instance
          .getUserProfile(appId: appId, piId: enteredPiId)
          .then((doc) {
        if (doc.exists) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('PI ID already in use. Choose another.')),
          );
          return; // Do not proceed
        } else {
          _persistAndNext();
        }
      });
    } else {
      _persistAndNext();
    }
  }

  void _persistAndNext() {
    // original logic moved here after uniqueness check

    final caregiver = CaregiverProfile(
      name: _name.text.trim(),
      age: int.tryParse(_age.text.trim()) ?? 0,
      phone: _phone.text.trim(),
      relationship: _relationship.text.trim(),
      address: _address.text.trim(),
    );
    final current = careContextNotifier.value;
    current.caregiver = caregiver;
    careContextNotifier.value = CareContext(
      caregiver: caregiver,
      elderly: current.elderly,
      appId: current.appId,
      piId: _piId.text.trim().isNotEmpty ? _piId.text.trim() : current.piId,
    );
    CareContextStorage.save(careContextNotifier.value);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ElderlyDetailsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caregiver details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _LabeledField(
                label: 'Full name',
                controller: _name,
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'Please enter your full name'
                    : null,
              ),
              const SizedBox(height: 12),
              _LabeledField(
                label: 'Age',
                controller: _age,
                keyboardType: TextInputType.number,
                validator: (v) {
                  final n = int.tryParse(v ?? '');
                  if (n == null || n < 16 || n > 100) return 'Enter a valid age';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _LabeledField(
                label: 'Phone number',
                controller: _phone,
                keyboardType: TextInputType.phone,
                validator: (v) => v == null || v.trim().length < 10
                    ? 'Enter a valid phone number'
                    : null,
              ),
              const SizedBox(height: 12),
              _LabeledField(
                label: 'Relationship to elderly',
                controller: _relationship,
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'Relationship is required'
                    : null,
              ),
              const SizedBox(height: 12),
              _LabeledField(
                label: 'Address',
                controller: _address,
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              _LabeledField(
                label: 'PI ID (hardware unique id)',
                controller: _piId,
                validator: (v) {
                  final value = v?.trim() ?? '';
                  if (value.isEmpty) return 'PI ID is required';
                  if (value.length < 6) return 'PI ID too short';
                  if (!RegExp(r'^[A-Za-z0-9_-]+$').hasMatch(value)) {
                    return 'Only letters, numbers, - and _ allowed';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _next,
                  child: const Text('Next: Elderly details'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int maxLines;

  const _LabeledField({
    required this.label,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
