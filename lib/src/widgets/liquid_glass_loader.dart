import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'liquid_glass_card.dart';
import '../foundation/liquid_responsive.dart';

class LiquidGlassLoader extends StatelessWidget {
  const LiquidGlassLoader({super.key, this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    final labelStyle =
        const TextStyle(color: Colors.white, fontSize: 14).liquidScale(context);

    return LiquidGlassCard(
      borderRadius: BorderRadius.circular(16),
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CupertinoActivityIndicator(color: Colors.white),
          if (label != null) ...[
            const SizedBox(width: 10),
            Text(label!, style: labelStyle),
          ],
        ],
      ),
    );
  }
}
