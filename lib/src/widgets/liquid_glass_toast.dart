import 'package:flutter/material.dart';

import 'liquid_glass_card.dart';

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
            borderRadius: BorderRadius.circular(14),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
