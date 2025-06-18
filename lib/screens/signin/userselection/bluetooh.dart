import 'package:flutter/material.dart';
import 'package:aayumitra/screens/homescreen/home.dart';

class BluetoothPage extends StatelessWidget {
  const BluetoothPage({super.key});

  void _showDeviceIdDialog(BuildContext context) {
    String inputId = '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Device ID'),
        content: TextField(
          onChanged: (value) => inputId = value,
          decoration: const InputDecoration(hintText: 'Device ID'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Add logic to handle inputId
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showPairedDevicesDialog(BuildContext context) {
    // TODO: Replace with dynamically fetched paired devices
    final pairedDevices = ['Device 1', 'Device 2'];
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Select Device'),
        children: pairedDevices
            .map(
              (device) => SimpleDialogOption(
                child: Text(device),
                onPressed: () {
                  Navigator.pop(context);
                  // TODO: Handle device selection
                },
              ),
            )
            .toList(),
      ),
    );
  }

  void _navigateToHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Simulated Bluetooth status
    final bool isBluetoothOn = false;

    return Scaffold(
      appBar: AppBar(title: const Text('Bluetooth Device Manager')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.devices),
              label: const Text('Link to Device'),
              onPressed: () => _showPairedDevicesDialog(context),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('New Device'),
              onPressed: () => _showDeviceIdDialog(context),
            ),
            const SizedBox(height: 20),
            // ElevatedButton.icon(
            //   icon: const Icon(Icons.home),
            //   label: const Text('Go to Home'),
            //   onPressed: () => _navigateToHome(context),
            // ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.bluetooth,
                  color: isBluetoothOn ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  isBluetoothOn ? 'Bluetooth is ON' : 'Bluetooth is OFF',
                  style: TextStyle(
                    color: isBluetoothOn ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
