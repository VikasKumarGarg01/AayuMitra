// import 'package:aayumitra/redundant/devices/bluetooh.dart';
// import 'package:aayumitra/screens/homescreen/home.dart';
// import 'package:aayumitra/screens/homescreen/navbar/emergency.dart';
import 'package:aayumitra/screens/homescreen/home.dart';
import 'package:aayumitra/screens/onboard/splash_screen.dart';
import 'package:aayumitra/screens/signin/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aayumitra/screens/signin/userselection/caregiver_details_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:aayumitra/services/care_context_persistence.dart';
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
  // Load persisted caregiver/elderly context so writes have correct appId/piId
  await CareContextStorage.loadIntoNotifier();
  runApp(const AayuMitraApp());
}

class AayuMitraApp extends StatelessWidget {
  const AayuMitraApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
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
          borderSide: const BorderSide(color: Colors.teal),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      colorScheme: const ColorScheme.light(
        primary: Colors.teal,
        secondary: Colors.teal,
        surface: Colors.white,
      ),
    );

    final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF121212),
      primaryColor: Colors.teal.shade200,
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF121212),
        foregroundColor: Colors.teal.shade200,
        iconTheme: IconThemeData(color: Colors.teal.shade200),
        titleTextStyle: TextStyle(
          color: Colors.teal.shade200,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal.shade400,
          foregroundColor: Colors.black,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: Colors.teal.shade200),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.all(Colors.teal.shade400),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal.shade200),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      colorScheme: ColorScheme.dark(
        primary: Colors.teal.shade200,
        secondary: Colors.teal.shade200,
        surface: const Color(0xFF121212),
      ),
    );

    return MaterialApp(
      title: 'AayuMitra',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system, // Respect system setting
      // Use auth wrapper to decide initial route based on auth state
      home: const AuthWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?> (
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show splash while determining auth state
          return const SplashScreen();
        }
        if (snapshot.hasData) {
          // User is signed in: check profile completion
          final uid = snapshot.data!.uid;
          return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              }
              final exists = snap.data?.exists == true;
              final profileCompleted = exists == true
                  ? (snap.data!.data()?['profileCompleted'] == true)
                  : false;
              if (!profileCompleted) {
                // Route first-time users to caregiver details
                return const CaregiverDetailsPage();
              }
              return const HomePageGate();
            },
          );
        }
        // Not signed in
        return const SignIn();
      },
    );
  }
}

/// A small gate to ensure CareContext is loaded before showing Home
class HomePageGate extends StatelessWidget {
  const HomePageGate({super.key});

  @override
  Widget build(BuildContext context) {
    // We already load CareContext at startup in main(); just show home.
    return const HomeScreen();
  }
}
