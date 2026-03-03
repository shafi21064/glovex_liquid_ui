import 'package:flutter/cupertino.dart';

import '../foundation/liquid_glass_theme.dart';
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
    this.blurMode = LiquidBlurMode.fake,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final LiquidBlurMode blurMode;

  @override
  Widget build(BuildContext context) {
    final theme = context.liquidGlassTheme;
    final hp = LiquidSizes.listTilePaddingHorizontal;
    final vp = LiquidSizes.listTilePaddingVertical;
    final titleStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: LiquidSizes.bodySize,
    ).copyWith(color: theme.highlightColor).liquidScale(context);
    final subtitleStyle = TextStyle(
      color: theme.highlightColor.withValues(alpha: 0.65),
      fontSize: LiquidSizes.smallSize,
    ).liquidScale(context);

    return CupertinoButton(
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      onPressed: onTap,
      child: LiquidGlassCard(
        borderRadius: BorderRadius.circular(LiquidSizes.radiusLg),
        blurMode: blurMode,
        padding: EdgeInsets.symmetric(horizontal: hp, vertical: vp),
        child: Row(
          children: [
            if (leading != null) ...[leading!, SizedBox(width: LiquidSizes.spacingSm)],
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
                Icon(
                  CupertinoIcons.chevron_right,
                  size: LiquidSizes.iconSm,
                  color: theme.highlightColor,
                ),
          ],
        ),
      ),
    );
  }
}
