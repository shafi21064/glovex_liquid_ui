import 'package:flutter/cupertino.dart';

import '../foundation/liquid_glass_theme.dart';
import 'liquid_glass_card.dart';
import '../foundation/liquid_responsive.dart';
import '../foundation/liquid_responsive_tokens.dart';

class LiquidGlassInput extends StatefulWidget {
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

  final TextEditingController controller;
  final String? placeholder;
  final Widget? prefix;
  final Widget? suffix;
  final bool obscureText;
  final bool showPasswordToggle;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
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
