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
    final titleStyle = const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 17,
    ).copyWith(color: theme.highlightColor).liquidScale(context);
    final subtitleStyle = TextStyle(
      color: theme.highlightColor.withValues(alpha: 0.7),
      fontSize: 13,
    ).liquidScale(context);
    final gap = LiquidSizes.sectionContentGap;

    return LiquidGlassCard(
      blurMode: blurMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: titleStyle),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(subtitle!, style: subtitleStyle),
          ],
          SizedBox(height: gap),
          ...children,
        ],
      ),
    );
  }
}
