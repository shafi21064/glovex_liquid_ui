import 'package:flutter/material.dart';

import 'liquid_glass_surface.dart';

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
    return LiquidGlassSurface(
      borderRadius: BorderRadius.circular(24),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }
}
