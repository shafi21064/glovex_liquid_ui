import 'package:flutter/material.dart';

import '../foundation/liquid_glass_theme.dart';
import 'liquid_glass_card.dart';
import '../foundation/liquid_responsive_tokens.dart';

class LiquidGlassModalSheet extends StatelessWidget {
  const LiquidGlassModalSheet({super.key, required this.child});

  final Widget child;

  static Future<T?> show<T>(BuildContext context, Widget child) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: LiquidGlassModalSheet(child: child),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LiquidGlassCard(
      blurMode: LiquidBlurMode.real,
      borderRadius: BorderRadius.circular(LiquidSizes.radiusXl),
      padding: EdgeInsets.all(LiquidSizes.spacingMd),
      child: child,
    );
  }
}
