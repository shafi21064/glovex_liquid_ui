import 'package:flutter/cupertino.dart';

import '../foundation/liquid_glass_theme.dart';
import 'liquid_glass_card.dart';
import '../foundation/liquid_responsive.dart';
import '../foundation/liquid_responsive_tokens.dart';

/// Cupertino-style text input wrapped in a liquid-glass card.
class LiquidGlassInput extends StatefulWidget {
  /// Creates a liquid-glass input.
  const LiquidGlassInput({
    super.key,
    required this.controller,
    this.placeholder,
    this.prefix,
    this.suffix,
    this.obscureText = false,
    this.showPasswordToggle = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.onSubmitted,
    this.onChanged,
    this.onTap,
  });

  /// Text editing controller.
  final TextEditingController controller;

  /// Placeholder text shown when empty.
  final String? placeholder;

  /// Optional leading widget.
  final Widget? prefix;

  /// Optional trailing widget.
  final Widget? suffix;

  /// Initial obscured state for secure text.
  final bool obscureText;

  /// Shows a built-in eye toggle for secure text.
  final bool showPasswordToggle;

  /// Keyboard type for the field.
  final TextInputType keyboardType;

  /// IME action button (next, done, search, etc).
  final TextInputAction? textInputAction;

  /// Callback when submitted from keyboard.
  final ValueChanged<String>? onSubmitted;

  /// Callback for text changes.
  final ValueChanged<String>? onChanged;

  /// Callback when input is tapped.
  final VoidCallback? onTap;

  @override
  State<LiquidGlassInput> createState() => _LiquidGlassInputState();
}

class _LiquidGlassInputState extends State<LiquidGlassInput> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  void didUpdateWidget(covariant LiquidGlassInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.obscureText != widget.obscureText &&
        !widget.showPasswordToggle) {
      _isObscured = widget.obscureText;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.liquidGlassTheme;
    final hp = LiquidSizes.inputPaddingHorizontal;
    final vp = LiquidSizes.inputPaddingVertical;
    final textStyle = TextStyle(
      color: theme.highlightColor,
      fontSize: LiquidSizes.labelSize,
    ).liquidScale(context);
    final placeholderStyle = TextStyle(
      color: theme.highlightColor.withValues(alpha: 0.6),
      fontSize: LiquidSizes.labelSize,
    ).liquidScale(context);

    Widget? effectiveSuffix = widget.suffix;
    if (widget.showPasswordToggle) {
      final toggle = CupertinoButton(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        onPressed: () => setState(() => _isObscured = !_isObscured),
        child: Icon(
          _isObscured ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
          size: LiquidSizes.iconSm,
          color: theme.highlightColor.withValues(alpha: 0.9),
        ),
      );
      if (widget.suffix == null) {
        effectiveSuffix = toggle;
      } else {
        effectiveSuffix = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.suffix!,
            SizedBox(width: LiquidSizes.spacingSm),
            toggle,
          ],
        );
      }
    }

    return LiquidGlassCard(
      blurMode: LiquidBlurMode.real,
      borderRadius: BorderRadius.circular(LiquidSizes.radiusLg),
      padding: EdgeInsets.symmetric(horizontal: hp, vertical: vp),
      child: Row(
        children: [
          if (widget.prefix != null) ...[
            widget.prefix!,
            SizedBox(width: LiquidSizes.spacingSm),
          ],
          Expanded(
            child: CupertinoTextField(
              controller: widget.controller,
              placeholder: widget.placeholder,
              obscureText: _isObscured,
              style: textStyle,
              placeholderStyle: placeholderStyle,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              decoration: null,
              cursorColor: theme.highlightColor,
              onSubmitted: widget.onSubmitted,
              onChanged: widget.onChanged,
              onTap: widget.onTap,
            ),
          ),
          if (effectiveSuffix != null) ...[
            SizedBox(width: LiquidSizes.spacingSm),
            effectiveSuffix,
          ],
        ],
      ),
    );
  }
}
