import 'dart:async';
import 'package:aayumitra/screens/homescreen/navbar/pricingplan.dart';
import 'package:flutter/material.dart';

class OfferCarousel extends StatefulWidget {
  const OfferCarousel({super.key});

  @override
  State<OfferCarousel> createState() => _OfferCarouselState();
}

class _OfferCarouselState extends State<OfferCarousel> {
  final PageController _controller = PageController();
  final List<String> images = [
    'assets/images/7.jpg',
    'assets/images/6.jpg',
    'assets/images/5.jpg',
  ];
  int _current = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_controller.hasClients) {
        int nextPage = (_current + 1) % images.length;
        _controller.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Carousel images
        SizedBox(
          width: 185,
          height: 150,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView.builder(
                controller: _controller,
                itemCount: images.length,
                onPageChanged: (i) => setState(() => _current = i),
                itemBuilder: (context, i) => ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    images[i],
                    fit: BoxFit.cover,
                    width: 140,
                    height: 140,
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    images.length,
                    (i) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == i
                            ? Colors.teal[100]
                            : Colors.grey[300],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // Offer details and button
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "UPTO 70% OFF",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text("On Caregiving Services, for first 100 users"),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PricingPolicyPage(),
                    ),
                  );
                },
                // ignore: sort_child_properties_last
                child: const Text("Book Now"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // use teal
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
