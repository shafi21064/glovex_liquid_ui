import 'package:flutter/material.dart';

import '../foundation/liquid_glass_theme.dart';
import 'liquid_glass_card.dart';
import '../foundation/liquid_responsive.dart';
import '../foundation/liquid_responsive_tokens.dart';

class LiquidGlassSection extends StatelessWidget {
  const LiquidGlassSection({
    super.key,
    required this.title,
    this.subtitle,
    required this.children,
    this.blurMode = LiquidBlurMode.fake,
  });

  final String title;
  final String? subtitle;
  final List<Widget> children;
  final LiquidBlurMode blurMode;

  @override
  Widget build(BuildContext context) {
    final theme = context.liquidGlassTheme;
    final titleStyle = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: LiquidSizes.titleSize,
    ).copyWith(color: theme.highlightColor).liquidScale(context);
    final subtitleStyle = TextStyle(
      color: theme.highlightColor.withValues(alpha: 0.7),
      fontSize: LiquidSizes.labelSize,
    ).liquidScale(context);
    final gap = LiquidSizes.sectionContentGap;

    return LiquidGlassCard(
      blurMode: blurMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: titleStyle),
          if (subtitle != null) ...[
            SizedBox(height: LiquidSizes.spacingXs),
            Text(subtitle!, style: subtitleStyle),
          ],
          SizedBox(height: gap),
          ...children,
        ],
      ),
    );
  }
}
