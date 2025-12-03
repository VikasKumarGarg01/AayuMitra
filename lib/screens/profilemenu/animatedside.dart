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
            child: Container(
              color: Theme.of(context).colorScheme.scrim.withOpacity(0.55),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: SlideTransition(
            position: _slideAnimation,
            child: FractionallySizedBox(
              widthFactor: 0.96,
              child: ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(32),
                ),
                child: Container(
                  // Transparent background to allow child (GlassCard) to define the visual
                  color: Colors.transparent,
                  child: Material(
                    // Provide Material context for InkWell/ListTile without painting a solid color
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 24, 8, 24),
                      child: SingleChildScrollView(child: widget.child),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
