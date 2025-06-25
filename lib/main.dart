// import 'package:aayumitra/redundant/devices/bluetooh.dart';
// import 'package:aayumitra/screens/homescreen/home.dart';
// import 'package:aayumitra/screens/homescreen/navbar/emergency.dart';
import 'package:aayumitra/screens/signin/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'screens/onboard/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp()
      .then((value) {
        // ignore: avoid_print
        print("Firebase Initialized");
      })
      .catchError((error) {
        // ignore: avoid_print
        print("Firebase Initialization Error: $error");
      });
  runApp(const AayuMitraApp());
}

class AayuMitraApp extends StatelessWidget {
  const AayuMitraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AayuMitra',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // Primary background as white
        primaryColor: Colors.teal,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.teal,
          iconTheme: IconThemeData(color: Colors.teal),
          titleTextStyle: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.teal),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.all(Colors.teal),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        colorScheme: ColorScheme.light(
          primary: Colors.teal,
          secondary: Colors.teal,
          surface: Colors.white,
        ),
      ),
      home: const SignIn(),
      debugShowCheckedModeBanner: false,
    );
  }
}
