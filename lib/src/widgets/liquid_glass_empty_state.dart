import 'package:flutter/material.dart';

import 'liquid_glass_card.dart';

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon ?? const Icon(Icons.inbox_outlined, color: Colors.white, size: 32),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
          ),
          if (action != null) ...[const SizedBox(height: 12), action!],
        ],
      ),
    );
  }
}
