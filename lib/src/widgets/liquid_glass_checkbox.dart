import 'package:flutter/material.dart';

class LiquidGlassCheckbox extends StatelessWidget {
  const LiquidGlassCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
      checkColor: Colors.white,
      fillColor: WidgetStatePropertyAll(Colors.white.withValues(alpha: 0.2)),
    );
  }
}
