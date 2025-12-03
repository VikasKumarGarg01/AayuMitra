
import 'package:aayumitra/screens/signin/userselection/caregiver_details_page.dart';
import 'package:flutter/material.dart';
import 'signin.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aayumitra/services/glass_widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool _agreed = false;

  // Controllers for form fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  bool get _canSignUp =>
      _formKey.currentState?.validate() == true &&
      _agreed &&
      _passwordController.text == _rePasswordController.text;

  Future<void> _signUpWithEmailPassword() async {
    if (!_canSignUp) return;
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      // On success, proceed to caregiver details
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const CaregiverDetailsPage()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = 'Email already in use.';
          break;
        case 'invalid-email':
          message = 'Invalid email address.';
          break;
        case 'operation-not-allowed':
          message = 'Email/password accounts are not enabled.';
          break;
        case 'weak-password':
          message = 'Password is too weak.';
          break;
        default:
          message = 'Sign-up failed (${e.code}).';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-up failed: $e')),
      );
    }
  }

  Future<void> _signUpWithGoogle() async {
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

      // After sign-in, check if user already exists in Firestore
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        throw Exception('No user after Google sign-in');
      }
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists) {
        // Existing user: show error and redirect to Sign In
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account already exists. Please sign in.')),
        );
        await FirebaseAuth.instance.signOut();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const SignIn()),
          (route) => false,
        );
        return;
      }

      // New user: go to caregiver details
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const CaregiverDetailsPage()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'account-exists-with-different-credential':
          message = 'Account exists with a different sign-in method.';
          break;
        case 'invalid-credential':
          message = 'Invalid Google credential.';
          break;
        case 'operation-not-allowed':
          message = 'Google sign-in not enabled.';
          break;
        case 'user-disabled':
          message = 'User account is disabled.';
          break;
        default:
          message = 'Google sign-in failed (${e.code}).';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } on PlatformException catch (e) {
      final details = e.details?.toString() ?? '';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Google sign-in failed (${e.code}): ${e.message ?? ''}${details.isNotEmpty ? '\nDetails: $details' : ''}',
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign-in failed: $e')),
      );
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
                      onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SignIn())),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Create your account',
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
                        child: Form(
                          key: _formKey,
                          onChanged: () => setState(() {}),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Image.asset('assets/images/logo.png', width: 56, height: 56),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('Welcome to AayuMitra!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                                        Text('Please login to start your journey', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),
                              TextFormField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                  hintText: 'How should we mail you?',
                                ),
                                validator: (v) => v == null || !v.contains('@') ? 'Enter a valid email' : null,
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                  hintText: 'Set a Strong Password that you can remember',
                                ),
                                validator: (v) => v == null || v.length < 6 ? 'Min 6 chars' : null,
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: _rePasswordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: 'Re-enter Password',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                  hintText: "Let's see if you remember it correctly",
                                ),
                                validator: (v) => v != _passwordController.text ? 'Passwords do not match' : null,
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Checkbox(value: _agreed, onChanged: (v) => setState(() => _agreed = v ?? false), activeColor: Colors.teal),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => setState(() => _agreed = !_agreed),
                                      child: const Text('I agree with Terms and Privacy Policy', style: TextStyle(decoration: TextDecoration.underline)),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _canSignUp ? _signUpWithEmailPassword : null,
                                  child: const Text('Sign Up'),
                                ),
                              ),
                              const SizedBox(height: 14),
                              Row(
                                children: const [
                                  Expanded(child: Divider()),
                                  SizedBox(width: 10),
                                  Text('or'),
                                  SizedBox(width: 10),
                                  Expanded(child: Divider()),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Center(
                                child: _SocialCircleButton(
                                  icon: Icons.g_mobiledata,
                                  color: Colors.red,
                                  onTap: _signUpWithGoogle,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Already have a Google account? '),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SignIn()));
                                    },
                                    child: const Text('Login'),
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
