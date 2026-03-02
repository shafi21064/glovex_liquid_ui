import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'liquid_glass_surface.dart';

class LiquidGlassLoader extends StatelessWidget {
  const LiquidGlassLoader({super.key, this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassSurface(
      borderRadius: BorderRadius.circular(16),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CupertinoActivityIndicator(color: Colors.white),
          if (label != null) ...[
            const SizedBox(width: 10),
            Text(label!, style: const TextStyle(color: Colors.white)),
          ],
        ],
      ),
    );
  }
}
