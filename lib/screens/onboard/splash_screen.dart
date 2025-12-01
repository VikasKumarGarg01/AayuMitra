import 'package:aayumitra/screens/signin/signup_page.dart';
import 'package:aayumitra/screens/signin/signin.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:ui';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showIntro = false;
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  double _logoOpacity = 0.0;

  final List<String> imagePaths = [
  'assets/images/6.jpg', // Medication / care
  'assets/images/2.jpg', // Analytics / tracking
  'assets/images/5.jpg', // Reminder / schedule
  'assets/images/7.jpg', // Wellness / support
  ];

  final List<String> descriptions = [
    'Welcome to AayuMitra! Your health companion for daily needs.',
    'Track your health and wellness with ease.',
    'Get reminders for medicines and appointments.',
    'Access health tips and connect with experts.',
  ];

  final List<String> paragraphs = [
    'AayuMitra helps you manage your health efficiently and effectively.',
    'Stay updated with your health records and progress.',
    'Never miss a dose or appointment with timely reminders.',
    'Empowering you to live a healthier life every day.',
  ];

  @override
  void initState() {
    super.initState();
    // Animate logo opacity while waiting
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() => _logoOpacity = 1.0);
      }
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showIntro = true;
        });
      }
    });
  }

  void _onNext() {
    if (_currentIndex < imagePaths.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _showSignInDialog();
    }
  }

  void _onSkip() {
    _showSignInDialog();
  }

  void _showSignInDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Continue your journey with AayuMitra',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const SignIn()),
                        );
                      },
                      child: const Text('Sign In'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const SignUpPage()),
                        );
                      },
                      child: const Text('Sign Up'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_showIntro) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.85),
                Theme.of(context).colorScheme.primary.withOpacity(0.55),
                Theme.of(context).colorScheme.primary.withOpacity(0.35),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                  opacity: _logoOpacity,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: Image.asset('assets/images/logo.png', width: 150, height: 150),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'AayuMitra',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Designed by Vikas Kumar Garg',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                        fontStyle: FontStyle.italic,
                      ),
                ),
                const SizedBox(height: 28),
                const CircularProgressIndicator(color: Colors.white),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // Fullscreen background image with page transitions
          PageView.builder(
            controller: _pageController,
            itemCount: imagePaths.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (context, index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      imagePaths[index],
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.95),
                            Colors.black.withOpacity(0.05),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // Content overlay (top controls removed)
          SafeArea(
            child: Column(
              children: const [
                Spacer(),
                // Floating translucent info card
                // The card is defined below
              ],
            ),
          ),
          // Floating translucent info card (kept in place)
          Positioned(
            left: 5,
            right: 5,
            bottom: 50,
            child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 90),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: Container(
                      key: ValueKey(_currentIndex),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                        child: Container(
                          padding: const EdgeInsets.all(22),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(color: Colors.white.withOpacity(0.25)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                descriptions[_currentIndex],
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 14),
                              Text(
                                paragraphs[_currentIndex],
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Colors.white.withOpacity(0.9),
                                      height: 1.4,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          ),
          // Bottom action bar with page indicator
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.96),
                    Colors.black.withOpacity(0.01),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: imagePaths.length,
                    effect: WormEffect(
                      dotColor: Colors.white.withOpacity(0.05),
                      activeDotColor: Theme.of(context).colorScheme.primary,
                      dotHeight: 10,
                      dotWidth: 10,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: BorderSide(color: Colors.white.withOpacity(0.3)),
                          ),
                          onPressed: _onSkip,
                          child: const Text('Skip'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: _onNext,
                          child: Text(_currentIndex == imagePaths.length - 1 ? 'Get Started' : 'Next'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
