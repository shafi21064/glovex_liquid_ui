import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'liquid_glass_card.dart';

class LiquidGlassBottomNavItem {
  const LiquidGlassBottomNavItem({
    required this.icon,
    required this.label,
    this.activeIcon,
  });

  final IconData icon;
  final IconData? activeIcon;
  final String label;
}

class LiquidGlassBottomNavBar extends StatelessWidget {
  const LiquidGlassBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
    this.height = 74,
    this.margin = const EdgeInsets.fromLTRB(14, 0, 14, 14),
    this.activeColor = Colors.white,
    this.inactiveColor,
    this.animationDuration = const Duration(milliseconds: 280),
    this.borderRadius = const BorderRadius.all(Radius.circular(26)),
    this.activatorRadius = const BorderRadius.all(Radius.circular(18)),
  }) : assert(items.length > 1, 'At least two bottom-nav items are required.');

  final int currentIndex;
  final List<LiquidGlassBottomNavItem> items;
  final ValueChanged<int> onTap;

  final double height;
  final EdgeInsetsGeometry margin;
  final Color activeColor;
  final Color? inactiveColor;
  final Duration animationDuration;
  final BorderRadius borderRadius;
  final BorderRadius activatorRadius;

  @override
  Widget build(BuildContext context) {
    final isDark = CupertinoTheme.of(context).brightness == Brightness.dark;
    final resolvedInactiveColor = inactiveColor ??
        (isDark ? Colors.white.withAlpha(150) : Colors.black.withAlpha(140));

    return Padding(
      padding: margin,
      child: SizedBox(
        height: height,
        child: LiquidGlassCard(
          borderRadius: borderRadius,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth = (constraints.maxWidth - 10) / items.length;

              return Stack(
                children: [
                  AnimatedAlign(
                    duration: animationDuration,
                    curve: Curves.easeOutCubic,
                    alignment: _alignmentForIndex(currentIndex, items.length),
                    child: IgnorePointer(
                      child: SizedBox(
                        width: itemWidth,
                        height: constraints.maxHeight,
                        child: LiquidGlassCard(
                          borderRadius: activatorRadius,
                          padding: EdgeInsets.zero,
                          child: const SizedBox.expand(),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: List.generate(items.length, (index) {
                      final item = items[index];
                      return Expanded(
                        child: _NavItem(
                          icon: item.icon,
                          activeIcon: item.activeIcon,
                          label: item.label,
                          selected: currentIndex == index,
                          activeColor: activeColor,
                          inactiveColor: resolvedInactiveColor,
                          animationDuration: animationDuration,
                          onTap: () => onTap(index),
                        ),
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  static Alignment _alignmentForIndex(int index, int total) {
    if (total <= 1) return Alignment.center;
    final t = index.clamp(0, total - 1) / (total - 1);
    final x = (t * 2) - 1;
    return Alignment(x, 0);
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.selected,
    required this.activeColor,
    required this.inactiveColor,
    required this.animationDuration,
    required this.onTap,
  });

  final IconData icon;
  final IconData? activeIcon;
  final String label;
  final bool selected;
  final Color activeColor;
  final Color inactiveColor;
  final Duration animationDuration;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? activeColor : inactiveColor;

    return CupertinoButton(
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      onPressed: onTap,
      child: SizedBox.expand(
        child: Center(
          child: AnimatedScale(
            duration: animationDuration,
            curve: Curves.easeOutCubic,
            scale: selected ? 1.0 : 0.96,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  selected && activeIcon != null ? activeIcon : icon,
                  size: selected ? 21 : 20,
                  color: color,
                ),
                const SizedBox(height: 3),
                AnimatedDefaultTextStyle(
                  duration: animationDuration,
                  curve: Curves.easeOutCubic,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                    color: color,
                  ),
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
