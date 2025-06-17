// --- Separate SignInPage ---
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.email),
              label: const Text('Sign in with Email'),
              onPressed: () {
                // Implement email sign-in
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.account_circle),
              label: const Text('Sign in with Google'),
              onPressed: () {
                // Implement Google sign-in
              },
            ),
          ],
        ),
      ),
    );
  }
}