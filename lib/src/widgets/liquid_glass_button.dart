import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'liquid_glass_card.dart';
import '../foundation/liquid_responsive.dart';
import '../foundation/liquid_responsive_tokens.dart';

enum LiquidGlassButtonVariant { primary, ghost }

class LiquidGlassButton extends StatelessWidget {
  const LiquidGlassButton({
    super.key,
    required this.label,
    this.leading,
    this.onPressed,
    this.variant = LiquidGlassButtonVariant.primary,
  });

  final String label;
  final Widget? leading;
  final VoidCallback? onPressed;
  final LiquidGlassButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    final primary = variant == LiquidGlassButtonVariant.primary;
    final fg = primary ? Colors.white : Colors.white.withValues(alpha: 0.9);
    final hp =
        context.liquidDouble(LiquidResponsiveTokens.buttonPaddingHorizontal);
    final vp =
        context.liquidDouble(LiquidResponsiveTokens.buttonPaddingVertical);
    final labelStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 15,
    ).copyWith(color: fg).liquidScale(context);

    return CupertinoButton(
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      onPressed: onPressed,
      child: LiquidGlassCard(
        borderRadius: BorderRadius.circular(16),
        padding: EdgeInsets.symmetric(horizontal: hp, vertical: vp),
        shrinkWrap: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leading != null) ...[leading!, const SizedBox(width: 8)],
            Text(
              label,
              style: labelStyle,
            ),
          ],
        ),
      ),
    );
  }
}
