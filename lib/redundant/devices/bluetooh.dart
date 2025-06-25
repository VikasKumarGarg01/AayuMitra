import 'package:flutter/material.dart';

class DeviceConnectScreen extends StatelessWidget {
  const DeviceConnectScreen({super.key});

  void _showDeviceIdDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        // ignore: unused_local_variable
        String inputId = '';
        return AlertDialog(
          title: const Text('Enter Device ID'),
          content: TextField(
            onChanged: (value) => inputId = value,
            decoration: const InputDecoration(hintText: 'Device ID'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // No logic, just close dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showPairedDevicesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Select Device'),
        children: [
          SimpleDialogOption(
            child: const Text('Device 1'),
            onPressed: () => Navigator.pop(context),
          ),
          SimpleDialogOption(
            child: const Text('Device 2'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connect to Device')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _showPairedDevicesDialog(context),
              child: const Text('Link to Device'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showDeviceIdDialog(context),
              child: const Text('New Device'),
            ),
            const SizedBox(height: 40),
            const Text(
              'Bluetooth is OFF',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
