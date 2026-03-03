import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../foundation/liquid_responsive_tokens.dart';

class LiquidGlassRadio<T> extends StatelessWidget {
  const LiquidGlassRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final selected = value == groupValue;

    return CupertinoButton(
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      onPressed: () => onChanged(value),
      child: Container(
        width: LiquidSizes.radioSize,
        height: LiquidSizes.radioSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.9),
            width: LiquidSizes.loadingStrokeWidth,
          ),
          color: selected
              ? Colors.white.withValues(alpha: 0.2)
              : Colors.transparent,
        ),
        child: selected
            ? Center(
                child: Container(
                  width: LiquidSizes.radioInnerSize,
                  height: LiquidSizes.radioInnerSize,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
