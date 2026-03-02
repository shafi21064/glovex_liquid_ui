import 'package:flutter/material.dart';

import 'liquid_glass_card.dart';
import '../foundation/liquid_responsive.dart';
import '../foundation/liquid_responsive_tokens.dart';

class LiquidGlassSection extends StatelessWidget {
  const LiquidGlassSection({
    super.key,
    required this.title,
    this.subtitle,
    required this.children,
  });

  final String title;
  final String? subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final titleStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 17,
    ).liquidScale(context);
    final subtitleStyle = TextStyle(
      color: Colors.white.withValues(alpha: 0.7),
      fontSize: 13,
    ).liquidScale(context);
    final gap = context.liquidDouble(LiquidResponsiveTokens.sectionContentGap);

    return LiquidGlassCard(
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
