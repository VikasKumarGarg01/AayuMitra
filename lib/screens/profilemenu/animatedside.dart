import 'package:flutter/material.dart';

class AnimatedSideSheet extends StatefulWidget {
  final Widget child;
  const AnimatedSideSheet({super.key, required this.child});

  @override
  State<AnimatedSideSheet> createState() => _AnimatedSideSheetState();
}

class _AnimatedSideSheetState extends State<AnimatedSideSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Tap outside to close
        Positioned.fill(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            // ignore: deprecated_member_use
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: SlideTransition(
            position: _slideAnimation,
            child: FractionallySizedBox(
              widthFactor: 0.6,
              child: Material(
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(32),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 24,
                  ),
                  child: SingleChildScrollView(child: widget.child),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
