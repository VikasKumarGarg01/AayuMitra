import 'dart:ui';
import 'package:flutter/material.dart';

/// A reusable glass-style container with configurable elevation, padding and border radius.
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double blur;
  final double opacity;
  final double borderOpacity;
  final BorderRadius borderRadius;
  final Color? accentBorder;
  final Color? tint;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.blur = 12,
    this.opacity = 0.12,
    this.borderOpacity = 0.25,
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
    this.accentBorder,
    this.tint,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = accentBorder ?? Colors.white.withOpacity(borderOpacity);
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: (tint ?? Colors.white).withOpacity(opacity),
            border: Border.all(color: borderColor),
          ),
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}

/// A glass button wrapper giving frosted background with unified style.
class GlassButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final double blur;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final Color? tint;
  final double opacity;

  const GlassButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.blur = 10,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.tint,
    this.opacity = 0.18,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Material(
          color: (tint ?? cs.primary).withOpacity(opacity),
          child: InkWell(
            onTap: onPressed,
            child: Padding(
              padding: padding,
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Utility to wrap an existing widget with subtle glass effect without altering layout.
class GlassOverlay extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final BorderRadius borderRadius;

  const GlassOverlay({
    super.key,
    required this.child,
    this.blur = 8,
    this.opacity = 0.10,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: Colors.white.withOpacity(opacity),
          ),
          child: child,
        ),
      ),
    );
  }
}
