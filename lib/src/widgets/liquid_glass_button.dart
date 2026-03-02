import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'liquid_glass_surface.dart';

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

    return CupertinoButton(
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      onPressed: onPressed,
      child: LiquidGlassSurface(
        borderRadius: BorderRadius.circular(16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leading != null) ...[leading!, const SizedBox(width: 8)],
            Text(
              label,
              style: TextStyle(color: fg, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
