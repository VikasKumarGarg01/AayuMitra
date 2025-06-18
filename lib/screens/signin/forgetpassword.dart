import 'package:aayumitra/screens/signin/signin.dart';
import 'package:aayumitra/screens/signin/userselection/user_role_page.dart';
import 'package:flutter/material.dart';
// import 'welcome_back_page.dart';
// import 'user_role_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _newPassController = TextEditingController();
  final _rePassController = TextEditingController();

  int _step = 0; // 0: email, 1: otp, 2: new password

  bool get _canContinue {
    if (_step == 0) {
      return _emailController.text.contains('@');
    } else if (_step == 1) {
      return _otpController.text.length == 6;
    } else if (_step == 2) {
      return _newPassController.text.length >= 6 &&
          _newPassController.text == _rePassController.text;
    }
    return false;
  }

  void _nextStep() {
    if (_step < 2) {
      setState(() => _step++);
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const SignIn()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String title;
    Widget content;
    if (_step == 0) {
      title = 'Reset Password';
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Enter your email to receive an OTP'),
          const SizedBox(height: 16),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (_) => setState(() {}),
          ),
        ],
      );
    } else if (_step == 1) {
      title = 'Enter OTP';
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Enter the 6-digit OTP sent to your email'),
          const SizedBox(height: 16),
          TextField(
            controller: _otpController,
            decoration: const InputDecoration(
              labelText: 'OTP',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            maxLength: 6,
            onChanged: (_) => setState(() {}),
          ),
        ],
      );
    } else {
      title = 'Set New Password';
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Enter your new password'),
          const SizedBox(height: 16),
          TextField(
            controller: _newPassController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'New Password',
              border: OutlineInputBorder(),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _rePassController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Re-enter Password',
              border: OutlineInputBorder(),
            ),
            onChanged: (_) => setState(() {}),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            if (_step == 0) {
              Navigator.pop(context);
            } else {
              setState(() => _step--);
            }
          },
        ),
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            content,
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _canContinue ? _nextStep : null,
                child: Text(_step < 2 ? 'Continue' : 'Reset Password'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
