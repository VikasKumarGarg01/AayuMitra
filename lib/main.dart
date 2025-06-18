import 'package:flutter/material.dart';
import 'screens/onboard/splash_screen.dart';

void main() {
  runApp(const AayuMitraApp());
}

class AayuMitraApp extends StatelessWidget {
  const AayuMitraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AayuMitra',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
