import 'dart:async';
import 'package:flutter/material.dart';

class EmergencyAlert extends StatefulWidget {
  const EmergencyAlert({super.key});

  @override
  State<EmergencyAlert> createState() => _EmergencyAlertState();
}

class _EmergencyAlertState extends State<EmergencyAlert>
    with SingleTickerProviderStateMixin {
  bool _blinking = false;
  bool _buttonRed = true;
  Timer? _timer;
  int _blinkCount = 0;
  double _effectRadius = 0.0;

  static const int maxBlinks = 12;
  static const Duration blinkDuration = Duration(milliseconds: 300);

  void _startBlinking() {
    if (_blinking) return;
    setState(() {
      _blinking = true;
      _blinkCount = 0;
      _buttonRed = true;
      _effectRadius = 0.0;
    });
    _timer = Timer.periodic(blinkDuration, (timer) {
      setState(() {
        _buttonRed = !_buttonRed;
        _effectRadius = _effectRadius == 0.0 ? 200.0 : 0.0;
        _blinkCount++;
        if (_blinkCount > maxBlinks) {
          _timer?.cancel();
          _blinking = false;
          _buttonRed = true;
          _effectRadius = 0.0;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final buttonSize = 250.0;
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circular animated effect radiating from button
          AnimatedContainer(
            duration: blinkDuration,
            width: buttonSize + _effectRadius,
            height: buttonSize + _effectRadius,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _effectRadius > 0
                  // ignore: deprecated_member_use
                  ? Colors.red.withOpacity(0.25)
                  : Colors.transparent,
            ),
          ),
          GestureDetector(
            onTap: _startBlinking,
            child: AnimatedContainer(
              duration: blinkDuration,
              width: buttonSize,
              height: buttonSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _buttonRed ? Colors.red[600] : Colors.white,
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.red.withOpacity(0.7),
                    blurRadius: 40,
                    spreadRadius: 20,
                  ),
                ],
                border: Border.all(color: Colors.red, width: 8),
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: _buttonRed ? Colors.white : Colors.red[600],
                  size: 90,
                  shadows: [
                    Shadow(
                      // ignore: deprecated_member_use
                      color: Colors.redAccent.withOpacity(0.7),
                      blurRadius: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
