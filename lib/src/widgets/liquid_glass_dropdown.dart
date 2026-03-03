import 'package:flutter/material.dart';

import '../foundation/liquid_glass_theme.dart';
import 'liquid_glass_card.dart';
import '../foundation/liquid_responsive_tokens.dart';

class LiquidGlassDropdown<T> extends StatelessWidget {
  const LiquidGlassDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassCard(
      blurMode: LiquidBlurMode.real,
      borderRadius: BorderRadius.circular(LiquidSizes.radiusLg),
      padding: EdgeInsets.symmetric(horizontal: LiquidSizes.spacingSm),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          dropdownColor: Colors.black.withValues(alpha: 0.85),
          value: value,
          items: items,
          iconEnabledColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
