import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../foundation/liquid_glass_theme.dart';
import 'liquid_glass_card.dart';
import '../foundation/liquid_responsive.dart';
import '../foundation/liquid_responsive_tokens.dart';
import 'liquid_glass_surface.dart';

enum LiquidGlassButtonVariant { primary, ghost }

class LiquidGlassButton extends StatelessWidget {
  const LiquidGlassButton({
    super.key,
    required this.label,
    this.leading,
    this.onPressed,
    this.variant = LiquidGlassButtonVariant.primary,
    this.expanded = false,
    this.alignment = Alignment.center,
  });

  final String label;
  final Widget? leading;
  final VoidCallback? onPressed;
  final LiquidGlassButtonVariant variant;
  final bool expanded;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    final theme = context.liquidGlassTheme;
    final primary = variant == LiquidGlassButtonVariant.primary;
    final fg = primary
        ? theme.highlightColor
        : theme.highlightColor.withValues(alpha: 0.9);
    final hp = LiquidSizes.buttonPaddingHorizontal;
    final vp = LiquidSizes.buttonPaddingVertical;
    final labelStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 15,
    ).copyWith(color: fg).liquidScale(context);

    final childRow = Row(
      mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: expanded ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        if (leading != null) ...[leading!, const SizedBox(width: 8)],
        Text(
          label,
          style: labelStyle,
        ),
      ],
    );

    final base = primary
        ? LiquidGlassCard(
            blurMode: LiquidBlurMode.real,
            borderRadius: BorderRadius.circular(16),
            padding: EdgeInsets.symmetric(horizontal: hp, vertical: vp),
            shrinkWrap: !expanded,
            child: childRow,
          )
        : LiquidGlassSurface(
            borderRadius: BorderRadius.circular(16),
            enableBlur: false,
            blurMode: LiquidBlurMode.fake,
            borderColor: theme.borderColor.withValues(alpha: 0.35),
            backgroundColor: theme.tintColor.withValues(alpha: 0.02),
            padding: EdgeInsets.symmetric(horizontal: hp, vertical: vp),
            child: childRow,
          );

    return CupertinoButton(
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      onPressed: onPressed,
      child: expanded
          ? SizedBox(
              width: double.infinity,
              child: Align(alignment: alignment, child: base),
            )
          : base,
    );
  }
}
