import 'package:aayumitra/screens/signin/signup_page.dart';
import 'package:aayumitra/screens/signin/signin.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showIntro = false;
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<String> imagePaths = [
    'assets/images/6.jpg',
    'assets/images/2.jpg',
    'assets/images/5.jpg',
    'assets/images/7.jpg',
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
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _showIntro = true;
      });
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign In'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.home),
              label: const Text('Sign In'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const SignIn()),
                );
              },
            ),

            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.home),
              label: const Text('Sign Up'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const SignUpPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_showIntro) {
  return Scaffold(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: 150, height: 150),
              const SizedBox(height: 20),
      Text(
        'AayuMitra',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 3,
        ),
      ),
      Text(
        'Designed by Vikas Kumar Garg',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontStyle: FontStyle.italic,
        ),
      ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: PageView.builder(
                controller: _pageController,
                itemCount: imagePaths.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(5, 5),
                            ),
                          ],
                        ),
                        width: 400,
                        height: 350,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            imagePaths[index],
                            fit: BoxFit.cover,
                            width: 400,
                            height: 350,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 5,
                          ),
                          child: Text(
                            paragraphs[index],
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontSize: 20,
                                  color:
                                      Theme.of(context).colorScheme.primary,
                                  fontStyle: FontStyle.italic,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SmoothPageIndicator(
                            controller: _pageController,
                            count: imagePaths.length,
                            effect: WormEffect(
                dotColor: Theme.of(context)
                  .colorScheme
                  .primary
                  .withOpacity(0.2),
                activeDotColor:
                  Theme.of(context).colorScheme.primary,
                              dotHeight: 8,
                              dotWidth: 8,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            descriptions[_currentIndex],
              style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color:
                    Theme.of(context).colorScheme.primary,
                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_currentIndex < imagePaths.length - 1)
                          TextButton(
                            onPressed: _onSkip,
                            child: const Text('Skip'),
                          ),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: _onNext,
                          child: Text(
                            _currentIndex == imagePaths.length - 1
                                ? 'Done'
                                : 'Next',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
