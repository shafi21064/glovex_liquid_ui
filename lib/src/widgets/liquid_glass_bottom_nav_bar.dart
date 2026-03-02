import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'liquid_glass_surface.dart';

class LiquidGlassBottomNavBar extends StatelessWidget {
  const LiquidGlassBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  final int currentIndex;
  final List<BottomNavigationBarItem> items;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassSurface(
      borderRadius: BorderRadius.circular(28),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: CupertinoTabBar(
        currentIndex: currentIndex,
        items: items,
        onTap: onTap,
        backgroundColor: Colors.transparent,
        activeColor: Colors.white,
        inactiveColor: Colors.white.withValues(alpha: 0.7),
      ),
    );
  }
}
