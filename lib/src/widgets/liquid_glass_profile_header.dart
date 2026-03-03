import 'package:flutter/material.dart';

import '../foundation/liquid_glass_theme.dart';
import 'liquid_glass_card.dart';
import '../foundation/liquid_responsive.dart';

class LiquidGlassProfileHeader extends StatelessWidget {
  const LiquidGlassProfileHeader({
    super.key,
    required this.name,
    this.email,
    this.avatar,
  });

  final String name;
  final String? email;
  final Widget? avatar;

  @override
  Widget build(BuildContext context) {
    final theme = context.liquidGlassTheme;
    final nameStyle = const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 17,
    ).copyWith(color: theme.highlightColor).liquidScale(context);
    final emailStyle = TextStyle(
      color: theme.highlightColor.withValues(alpha: 0.7),
      fontSize: 13,
    ).liquidScale(context);

    return LiquidGlassCard(
      blurMode: LiquidBlurMode.real,
      child: Row(
        children: [
          avatar ?? const CircleAvatar(radius: 26, child: Icon(Icons.person)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: nameStyle),
                if (email != null) Text(email!, style: emailStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
