import 'package:flutter/cupertino.dart';

import 'liquid_glass_surface.dart';

class LiquidGlassIconButton extends StatelessWidget {
  const LiquidGlassIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 42,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      onPressed: onPressed,
      child: SizedBox(
        width: size,
        height: size,
        child: LiquidGlassSurface(
          borderRadius: BorderRadius.circular(size / 2),
          padding: const EdgeInsets.all(8),
          child: Center(child: icon),
        ),
      ),
    );
  }
}
