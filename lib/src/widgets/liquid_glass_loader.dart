import 'package:flutter/cupertino.dart';

import '../foundation/liquid_glass_theme.dart';
import 'liquid_glass_card.dart';
import '../foundation/liquid_responsive.dart';

class LiquidGlassLoader extends StatelessWidget {
  const LiquidGlassLoader({super.key, this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    final theme = context.liquidGlassTheme;
    final labelStyle = TextStyle(
      color: theme.highlightColor,
      fontSize: 14,
    ).liquidScale(context);

    return LiquidGlassCard(
      blurMode: LiquidBlurMode.real,
      borderRadius: BorderRadius.circular(16),
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoActivityIndicator(color: theme.highlightColor),
          if (label != null) ...[
            const SizedBox(width: 10),
            Text(label!, style: labelStyle),
          ],
        ],
      ),
    );
  }
}
