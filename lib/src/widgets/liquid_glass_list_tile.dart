import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'liquid_glass_card.dart';
import '../foundation/liquid_responsive.dart';
import '../foundation/liquid_responsive_tokens.dart';

class LiquidGlassListTile extends StatelessWidget {
  const LiquidGlassListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final hp =
        context.liquidDouble(LiquidResponsiveTokens.listTilePaddingHorizontal);
    final vp =
        context.liquidDouble(LiquidResponsiveTokens.listTilePaddingVertical);
    final titleStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 15,
    ).liquidScale(context);
    final subtitleStyle = TextStyle(
      color: Colors.white.withValues(alpha: 0.65),
      fontSize: 12,
    ).liquidScale(context);

    return CupertinoButton(
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      onPressed: onTap,
      child: LiquidGlassCard(
        borderRadius: BorderRadius.circular(14),
        padding: EdgeInsets.symmetric(horizontal: hp, vertical: vp),
        child: Row(
          children: [
            if (leading != null) ...[leading!, const SizedBox(width: 10)],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: titleStyle),
                  if (subtitle != null) Text(subtitle!, style: subtitleStyle),
                ],
              ),
            ),
            trailing ??
                const Icon(CupertinoIcons.chevron_right,
                    size: 16, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
