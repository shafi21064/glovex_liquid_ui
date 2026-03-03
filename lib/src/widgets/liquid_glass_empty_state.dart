import 'package:flutter/material.dart';

import '../foundation/liquid_glass_theme.dart';
import 'liquid_glass_card.dart';
import '../foundation/liquid_responsive_tokens.dart';

class LiquidGlassEmptyState extends StatelessWidget {
  const LiquidGlassEmptyState({
    super.key,
    required this.title,
    required this.message,
    this.icon,
    this.action,
  });

  final String title;
  final String message;
  final Widget? icon;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassCard(
      blurMode: LiquidBlurMode.real,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon ?? Icon(Icons.inbox_outlined, color: Colors.white, size: LiquidSizes.iconXl),
          SizedBox(height: LiquidSizes.spacingSm),
          Text(title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w700)),
          SizedBox(height: LiquidSizes.spacingXs),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
          ),
          if (action != null) ...[SizedBox(height: LiquidSizes.spacingMd), action!],
        ],
      ),
    );
  }
}
