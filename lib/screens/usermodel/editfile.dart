import 'package:aayumitra/screens/usermodel/userdata.dart';
import 'package:flutter/material.dart';

// import 'user_data.dart'; // import the file above
void _editField(BuildContext context, String field, String currentValue) async {
  final controller = TextEditingController(text: currentValue);
  final result = await showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Edit $field'),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: 'Enter new $field'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, controller.text),
          child: const Text('Save'),
        ),
      ],
    ),
  );
  if (result != null && result.trim().isNotEmpty) {
    final user = userNotifier.value;
    // Update the relevant field
    if (field == 'Name') user.name = result.trim();
    if (field == 'Email') user.email = result.trim();
    if (field == 'Address') user.address = result.trim();
    if (field == 'Phone') user.phone = result.trim();
    // Notify listeners by assigning a new instance
    userNotifier.value = UserData(
      name: user.name,
      email: user.email,
      address: user.address,
      phone: user.phone,
    );
  }
}
