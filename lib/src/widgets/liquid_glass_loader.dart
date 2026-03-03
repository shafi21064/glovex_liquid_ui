import 'package:flutter/cupertino.dart';

import '../foundation/liquid_glass_theme.dart';
import 'liquid_glass_card.dart';
import '../foundation/liquid_responsive.dart';
import '../foundation/liquid_responsive_tokens.dart';

class LiquidGlassLoader extends StatelessWidget {
  const LiquidGlassLoader({super.key, this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    final theme = context.liquidGlassTheme;
    final labelStyle = TextStyle(
      color: theme.highlightColor,
      fontSize: LiquidSizes.labelSize,
    ).liquidScale(context);

    return LiquidGlassCard(
      blurMode: LiquidBlurMode.real,
      borderRadius: BorderRadius.circular(LiquidSizes.radiusLg),
      padding: EdgeInsets.all(LiquidSizes.spacingMd),
      shrinkWrap: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoActivityIndicator(color: theme.highlightColor),
          if (label != null) ...[
            SizedBox(width: LiquidSizes.spacingSm),
            Text(label!, style: labelStyle),
          ],
        ],
      ),
    );
  }
}
