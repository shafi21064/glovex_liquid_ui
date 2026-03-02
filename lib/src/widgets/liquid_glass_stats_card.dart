import 'package:flutter/material.dart';

import 'liquid_glass_card.dart';
import '../foundation/liquid_responsive.dart';

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
    final labelStyle = TextStyle(
      color: Colors.white.withValues(alpha: 0.75),
      fontSize: 13,
    ).liquidScale(context);
    final valueStyle = const TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ).liquidScale(context);
    final trendStyle = TextStyle(
      color: Colors.white.withValues(alpha: 0.85),
      fontSize: 13,
    ).liquidScale(context);

    return LiquidGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: labelStyle),
          const SizedBox(height: 6),
          Text(value, style: valueStyle),
          if (trend != null) ...[
            const SizedBox(height: 4),
            Text(trend!, style: trendStyle),
          ],
        ],
      ),
    );
  }
}
