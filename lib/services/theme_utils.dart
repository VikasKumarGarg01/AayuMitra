import 'package:flutter/material.dart';

/// Common themed surfaces and text helpers to standardize dark-mode friendly UI.
class ThemeUtils {
  static BoxDecoration elevatedSurface(BuildContext context,
      {double radius = 12, double blur = 10, Offset offset = const Offset(5, 5)}) {
    final color = Theme.of(context).colorScheme.surface;
    final shadowColor = Theme.of(context).colorScheme.primary.withOpacity(0.15);
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        BoxShadow(color: shadowColor, blurRadius: blur, offset: offset),
      ],
    );
  }

  static TextStyle primaryAccentText(BuildContext context,
      {double fontSize = 16, FontWeight fontWeight = FontWeight.w600}) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontSize: fontSize,
          fontWeight: fontWeight,
        );
  }
}
