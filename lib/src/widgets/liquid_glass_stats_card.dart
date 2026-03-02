import 'package:flutter/material.dart';

import 'liquid_glass_card.dart';

class LiquidGlassStatsCard extends StatelessWidget {
  const LiquidGlassStatsCard({
    super.key,
    required this.label,
    required this.value,
    this.trend,
  });

  final String label;
  final String value;
  final String? trend;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.white.withValues(alpha: 0.75))),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700)),
          if (trend != null) ...[
            const SizedBox(height: 4),
            Text(trend!, style: TextStyle(color: Colors.white.withValues(alpha: 0.85))),
          ],
        ],
      ),
    );
  }
}
