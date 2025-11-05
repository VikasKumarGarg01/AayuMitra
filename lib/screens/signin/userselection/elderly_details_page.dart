import 'package:aayumitra/screens/homescreen/home.dart';
import 'package:aayumitra/screens/usermodel/care_models.dart';
import 'package:aayumitra/services/firestore_service.dart';
import 'package:aayumitra/services/care_context_persistence.dart';
import 'package:flutter/material.dart';

class ElderlyDetailsPage extends StatefulWidget {
  const ElderlyDetailsPage({super.key});

  @override
  State<ElderlyDetailsPage> createState() => _ElderlyDetailsPageState();
}

class _ElderlyDetailsPageState extends State<ElderlyDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _age = TextEditingController();
  final _phone = TextEditingController();
  final _conditions = TextEditingController();
  final _address = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _age.dispose();
    _phone.dispose();
    _conditions.dispose();
    _address.dispose();
    super.dispose();
  }

  void _finish() {
    if (!_formKey.currentState!.validate()) return;

    final elderly = ElderlyProfile(
      name: _name.text.trim(),
      age: int.tryParse(_age.text.trim()) ?? 0,
      phone: _phone.text.trim(),
      conditions: _conditions.text.trim(),
      address: _address.text.trim(),
    );

    final current = careContextNotifier.value;
    // Determine appId and piId (fallbacks if not set elsewhere)
    final appId = current.appId ?? 'aayu-mitra-app';
    // Try to derive a deterministic piId from elderly phone if possible
    final sanitizedPhone = elderly.phone.replaceAll(RegExp(r'[^0-9]'), '');
    final fallbackPiId = sanitizedPhone.isNotEmpty
        ? 'pi-${sanitizedPhone}'
        : 'pi-hub-001';
    final piId = current.piId ?? fallbackPiId;

    // Persist long-term user profile for LLM memory
    FirestoreService.instance.upsertUserProfile(
      appId: appId,
      piId: piId,
      data: {
        // Elderly (hub user) core and extended fields
        'name': elderly.name,
        'age': elderly.age,
        'phone': elderly.phone,
        'address': elderly.address,
        'conditions': elderly.conditions,
        'notes': '',
        'sleep_schedule': {
          'planned_bedtime': '',
          'planned_wakeup': '',
        },
        if (current.caregiver != null)
          'caregiver': {
            'name': current.caregiver!.name,
            'age': current.caregiver!.age,
            'phone': current.caregiver!.phone,
            'relationship': current.caregiver!.relationship,
            'address': current.caregiver!.address,
          },
      },
    );

    final newContext = CareContext(
      caregiver: current.caregiver,
      elderly: elderly,
      appId: appId,
      piId: piId,
    );
    careContextNotifier.value = newContext;
  CareContextStorage.save(newContext);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elderly details'),
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
                    ? 'Please enter full name'
                    : null,
              ),
              const SizedBox(height: 12),
              _LabeledField(
                label: 'Age',
                controller: _age,
                keyboardType: TextInputType.number,
                validator: (v) {
                  final n = int.tryParse(v ?? '');
                  if (n == null || n < 40 || n > 120) {
                    return 'Enter a valid age';
                  }
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
                label: 'Health conditions (optional)',
                controller: _conditions,
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              _LabeledField(
                label: 'Address',
                controller: _address,
                maxLines: 2,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _finish,
                  child: const Text('Finish and continue'),
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
