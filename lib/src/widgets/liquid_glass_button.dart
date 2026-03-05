import 'package:flutter/cupertino.dart';

import '../foundation/liquid_glass_theme.dart';
import 'liquid_glass_card.dart';
import '../foundation/liquid_responsive.dart';
import '../foundation/liquid_responsive_tokens.dart';
import 'liquid_glass_surface.dart';

/// Visual style variants for [LiquidGlassButton].
enum LiquidGlassButtonVariant { primary, ghost }

/// A liquid-glass button with primary and ghost variants.
class LiquidGlassButton extends StatelessWidget {
  /// Creates a liquid-glass button.
  const LiquidGlassButton({
    super.key,
    required this.label,
    this.leading,
    this.onPressed,
    this.variant = LiquidGlassButtonVariant.primary,
    this.expanded = false,
    this.alignment = Alignment.center,
  });

  /// Button label text.
  final String label;

  /// Optional widget shown before [label].
  final Widget? leading;

  /// Tap callback. If null, the button is disabled.
  final VoidCallback? onPressed;

  /// Visual variant of the button.
  final LiquidGlassButtonVariant variant;

  /// Expands button width to fill parent constraints.
  final bool expanded;

  /// Content alignment used when [expanded] is true.
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    final theme = context.liquidGlassTheme;
    final resolvedAlignment = alignment.resolve(Directionality.of(context));
    final expandedMainAxisAlignment = resolvedAlignment.x < -0.33
        ? MainAxisAlignment.start
        : resolvedAlignment.x > 0.33
            ? MainAxisAlignment.end
            : MainAxisAlignment.center;
    final primary = variant == LiquidGlassButtonVariant.primary;
    final fg = primary
        ? theme.highlightColor
        : theme.highlightColor.withValues(alpha: 0.9);
    final hp = LiquidSizes.buttonPaddingHorizontal;
    final vp = LiquidSizes.buttonPaddingVertical;
    final labelStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: LiquidSizes.labelSize,
    ).copyWith(color: fg).liquidScale(context);

    final childRow = Row(
      mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment:
          expanded ? expandedMainAxisAlignment : MainAxisAlignment.start,
      children: [
        if (leading != null) ...[
          leading!,
          SizedBox(width: LiquidSizes.spacingSm),
        ],
        Text(
          label,
          style: labelStyle,
        ),
      ],
    );

    final base = primary
        ? LiquidGlassCard(
            blurMode: LiquidBlurMode.real,
            borderRadius: BorderRadius.circular(LiquidSizes.radiusLg),
            padding: EdgeInsets.symmetric(horizontal: hp, vertical: vp),
            shrinkWrap: !expanded,
            child: childRow,
          )
        : LiquidGlassSurface(
            borderRadius: BorderRadius.circular(LiquidSizes.radiusLg),
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
      child: expanded ? SizedBox(width: double.infinity, child: base) : base,
    );
  }
}
