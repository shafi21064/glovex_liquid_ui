import 'package:flutter/material.dart';

import '../foundation/liquid_glass_theme.dart';
import 'liquid_glass_card.dart';
import '../foundation/liquid_responsive_tokens.dart';

class LiquidGlassToast {
  static void show(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (context) => Positioned(
        left: 16,
        right: 16,
        bottom: 32,
        child: Material(
          color: Colors.transparent,
          child: LiquidGlassCard(
            blurMode: LiquidBlurMode.real,
            borderRadius: BorderRadius.circular(LiquidSizes.radiusLg),
            padding: EdgeInsets.symmetric(horizontal: LiquidSizes.spacingMd, vertical: LiquidSizes.spacingSm),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);
    Future<void>.delayed(duration, entry.remove);
  }
}
