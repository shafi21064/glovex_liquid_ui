import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'liquid_glass_surface.dart';

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
    return LiquidGlassSurface(
      borderRadius: BorderRadius.circular(14),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          if (prefix != null) ...[prefix!, const SizedBox(width: 8)],
          Expanded(
            child: CupertinoTextField(
              controller: controller,
              placeholder: placeholder,
              obscureText: obscureText,
              style: const TextStyle(color: Colors.white),
              placeholderStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
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
