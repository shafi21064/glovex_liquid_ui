import 'package:flutter/cupertino.dart';

import 'liquid_glass_card.dart';
import '../foundation/liquid_responsive_tokens.dart';

class LiquidGlassIconButton extends StatelessWidget {
  const LiquidGlassIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      onPressed: onPressed,
      child: SizedBox(
        width: size ?? LiquidSizes.iconButtonSize,
        height: size ?? LiquidSizes.iconButtonSize,
        child: LiquidGlassCard(
          borderRadius: BorderRadius.circular((size ?? LiquidSizes.iconButtonSize) / 2),
          padding: EdgeInsets.all(LiquidSizes.spacingSm),
          child: Center(child: icon),
        ),
      ),
    );
  }
}
