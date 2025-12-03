// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:aayumitra/screens/homescreen/home.dart';
import 'package:aayumitra/screens/signin/forgetpassword.dart';
import 'signup_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:aayumitra/services/glass_widgets.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _remember = false;

  bool get _canSignIn =>
      _emailController.text.contains('@') && _passController.text.length >= 6;

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // User cancelled

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      // Navigate to home on success
      Navigator.pushAndRemoveUntil(
        // ignore: duplicate_ignore
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );
    } on PlatformException catch (e) {
      // Surface detailed platform error (e.g., ApiException: 10)
      final details = e.details?.toString() ?? '';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Google sign-in failed (${e.code}): ${e.message ?? ''} ${details.isNotEmpty ? '\nDetails: $details' : ''}',
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Google sign-in failed: $e')));
    }
  }

  Future<void> _signInWithEmailPassword() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passController.text,
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Sign-in failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Column(
            children: [
              // Header glass bar
              GlassCard(
                blur: 18,
                opacity: Theme.of(context).brightness == Brightness.dark ? 0.08 : 0.16,
                borderOpacity: 0.28,
                borderRadius: const BorderRadius.all(Radius.circular(18)),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Welcome back to AayuMitra',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 520),
                      child: GlassCard(
                        blur: 22,
                        opacity: Theme.of(context).brightness == Brightness.dark ? 0.10 : 0.20,
                        borderOpacity: 0.30,
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        padding: const EdgeInsets.fromLTRB(22, 24, 22, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Logo and title
                            Row(
                              children: [
                                Image.asset('assets/images/logo.png', width: 56, height: 56),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Welcome!',
                                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        'Please login to start your journey',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18),
                            // Email
                            Text('Email', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                            const SizedBox(height: 6),
                            TextField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter your email',
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (_) => setState(() {}),
                            ),
                            const SizedBox(height: 14),
                            // Password
                            Text('Password', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                            const SizedBox(height: 6),
                            TextField(
                              controller: _passController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter your password',
                              ),
                              onChanged: (_) => setState(() {}),
                            ),
                            const SizedBox(height: 8),
                            // Remember + Forgot
                            Row(
                              children: [
                                Checkbox(value: _remember, onChanged: (v) => setState(() => _remember = v ?? false)),
                                const Text('Remember'),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordPage()));
                                  },
                                  child: const Text('Forgot Password?'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            // Sign in
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _canSignIn ? _signInWithEmailPassword : null,
                                child: const Text('Sign In'),
                              ),
                            ),
                            const SizedBox(height: 18),
                            // Google
                            Center(
                              child: _SocialCircleButton(
                                icon: Icons.g_mobiledata,
                                color: Colors.red,
                                onTap: _signInWithGoogle,
                              ),
                            ),
                            const SizedBox(height: 18),
                            // Sign up link
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account? ", style: Theme.of(context).textTheme.bodyMedium),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SignUpPage()));
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialCircleButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _SocialCircleButton({
    required this.icon,
    required this.color,
    required this.onTap,
    // ignore: unused_element_parameter
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: CircleAvatar(
        radius: 24,
        // ignore: deprecated_member_use
        backgroundColor: color.withOpacity(0.1),
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }
}
