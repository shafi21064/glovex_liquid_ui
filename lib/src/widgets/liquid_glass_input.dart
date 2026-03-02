import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'liquid_glass_card.dart';
import '../foundation/liquid_responsive.dart';
import '../foundation/liquid_responsive_tokens.dart';

class LiquidGlassInput extends StatelessWidget {
  const LiquidGlassInput({
    super.key,
    required this.controller,
    this.placeholder,
    this.prefix,
    this.suffix,
    this.obscureText = false,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final String? placeholder;
  final Widget? prefix;
  final Widget? suffix;
  final bool obscureText;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final hp =
        context.liquidDouble(LiquidResponsiveTokens.inputPaddingHorizontal);
    final vp =
        context.liquidDouble(LiquidResponsiveTokens.inputPaddingVertical);
    final textStyle =
        const TextStyle(color: Colors.white, fontSize: 14).liquidScale(context);
    final placeholderStyle = TextStyle(
      color: Colors.white.withValues(alpha: 0.6),
      fontSize: 14,
    ).liquidScale(context);

    return LiquidGlassCard(
      borderRadius: BorderRadius.circular(14),
      padding: EdgeInsets.symmetric(horizontal: hp, vertical: vp),
      child: Row(
        children: [
          if (prefix != null) ...[prefix!, const SizedBox(width: 8)],
          Expanded(
            child: CupertinoTextField(
              controller: controller,
              placeholder: placeholder,
              obscureText: obscureText,
              style: textStyle,
              placeholderStyle: placeholderStyle,
              decoration: null,
              cursorColor: Colors.white,
              onSubmitted: onSubmitted,
            ),
          ),
          if (suffix != null) ...[const SizedBox(width: 8), suffix!],
        ],
      ),
    );
  }
}
