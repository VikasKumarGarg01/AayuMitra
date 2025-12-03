# aayumitra

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:



## Features
...existing content...

### Glass UI Components
Reusable frosted glass widgets live in `lib/services/glass_widgets.dart`:
* `GlassCard`: Container with blur, adjustable opacity, border and optional accent.
* `GlassButton`: Tappable frosted button with primary tint.
* `GlassOverlay`: Lightweight blur overlay wrapper.

Usage example:
```dart
import 'package:aayumitra/services/glass_widgets.dart';

Widget build(BuildContext context) {
	return GlassCard(
		child: Column(
			children: [
				Text('Frosted panel', style: Theme.of(context).textTheme.titleMedium),
				const SizedBox(height: 12),
				GlassButton(
					onPressed: () {},
					child: const Text('Action'),
				),
			],
		),
	);
}
```

Tuning parameters: `blur`, `opacity`, `borderOpacity`, `accentBorder` for color accent, and `borderRadius` for shape.

When adapting existing cards (e.g. highlight / controls pages), wrap the interior Row/Column with `GlassCard` and remove prior BoxDecoration/shadow for consistent look.
