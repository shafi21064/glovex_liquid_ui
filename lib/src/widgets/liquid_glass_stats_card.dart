import 'package:flutter/material.dart';

import '../foundation/liquid_glass_theme.dart';
import 'liquid_glass_card.dart';
import '../foundation/liquid_responsive.dart';
import '../foundation/liquid_responsive_tokens.dart';

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
    final theme = context.liquidGlassTheme;
    final labelStyle = TextStyle(
      color: theme.highlightColor.withValues(alpha: 0.75),
      fontSize: LiquidSizes.labelSize,
    ).liquidScale(context);
    final valueStyle = TextStyle(
      fontSize: LiquidSizes.titleSize,
      fontWeight: FontWeight.w700,
    ).copyWith(color: theme.highlightColor).liquidScale(context);
    final trendStyle = TextStyle(
      color: theme.highlightColor.withValues(alpha: 0.85),
      fontSize: LiquidSizes.labelSize,
    ).liquidScale(context);

    return LiquidGlassCard(
      blurMode: LiquidBlurMode.real,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: labelStyle),
          SizedBox(height: LiquidSizes.spacingSm),
          Text(value, style: valueStyle),
          if (trend != null) ...[
            SizedBox(height: LiquidSizes.spacingXs),
            Text(trend!, style: trendStyle),
          ],
        ],
      ),
    );
  }
}
