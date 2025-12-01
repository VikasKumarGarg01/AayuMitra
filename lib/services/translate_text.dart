import 'package:flutter/material.dart';
import 'translation_service.dart';

class TText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? align;
  const TText(this.text, {super.key, this.style, this.align});

  @override
  State<TText> createState() => _TTextState();
}

class _TTextState extends State<TText> {
  String _display = '';

  @override
  void initState() {
    super.initState();
    _display = widget.text;
    _translate();
  }

  @override
  void didUpdateWidget(covariant TText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _display = widget.text;
      _translate();
    }
  }

  Future<void> _translate() async {
    final translated = await TranslationService.instance.translate(widget.text);
    if (mounted) setState(() => _display = translated);
  }

  @override
  Widget build(BuildContext context) {
    return Text(_display, style: widget.style, textAlign: widget.align);
  }
}
