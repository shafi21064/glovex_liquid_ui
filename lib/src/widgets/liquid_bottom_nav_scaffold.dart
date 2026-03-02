import 'package:flutter/material.dart';

import 'liquid_glass_bottom_nav_bar.dart';

/// A simple shell scaffold that keeps the bottom nav fixed and only switches
/// the content area. Useful when you don't use a router.
class LiquidBottomNavScaffold extends StatelessWidget {
  const LiquidBottomNavScaffold({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    required this.children,
    this.preserveState = true,
    this.padding,
    this.background,
    this.navHeight = 74,
    this.navMargin = const EdgeInsets.fromLTRB(14, 0, 14, 14),
    this.navActiveColor = Colors.white,
    this.navInactiveColor,
    this.navAnimationDuration = const Duration(milliseconds: 280),
    this.navBorderRadius = const BorderRadius.all(Radius.circular(26)),
    this.navActivatorRadius = const BorderRadius.all(Radius.circular(18)),
  })  : routerChild = null,
        assert(items.length == children.length,
            'items and children length must be equal.');

  /// Router-friendly shell. Use this with `ShellRoute` child.
  const LiquidBottomNavScaffold.router({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    required this.routerChild,
    this.padding,
    this.background,
    this.navHeight = 74,
    this.navMargin = const EdgeInsets.fromLTRB(14, 0, 14, 14),
    this.navActiveColor = Colors.white,
    this.navInactiveColor,
    this.navAnimationDuration = const Duration(milliseconds: 280),
    this.navBorderRadius = const BorderRadius.all(Radius.circular(26)),
    this.navActivatorRadius = const BorderRadius.all(Radius.circular(18)),
  })  : children = const [],
        preserveState = false;

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<LiquidGlassBottomNavItem> items;
  final List<Widget> children;
  final Widget? routerChild;
  final bool preserveState;
  final EdgeInsetsGeometry? padding;
  final Widget? background;
  final double navHeight;
  final EdgeInsetsGeometry navMargin;
  final Color navActiveColor;
  final Color? navInactiveColor;
  final Duration navAnimationDuration;
  final BorderRadius navBorderRadius;
  final BorderRadius navActivatorRadius;

  @override
  Widget build(BuildContext context) {
    final body = routerChild ?? _buildChildrenBody();

    return Stack(
      children: [
        if (background != null) Positioned.fill(child: background!),
        SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: padding ?? EdgeInsets.zero,
                  child: body,
                ),
              ),
              LiquidGlassBottomNavBar(
                currentIndex: currentIndex,
                items: items,
                onTap: onTap,
                height: navHeight,
                margin: navMargin,
                activeColor: navActiveColor,
                inactiveColor: navInactiveColor,
                animationDuration: navAnimationDuration,
                borderRadius: navBorderRadius,
                activatorRadius: navActivatorRadius,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChildrenBody() {
    return preserveState
        ? IndexedStack(index: currentIndex, children: children)
        : AnimatedSwitcher(
            duration: const Duration(milliseconds: 260),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            transitionBuilder: (child, animation) {
              final slide = Tween<Offset>(
                begin: const Offset(0.03, 0),
                end: Offset.zero,
              ).animate(animation);
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(position: slide, child: child),
              );
            },
            child: KeyedSubtree(
              key: ValueKey(currentIndex),
              child: children[currentIndex],
            ),
          );
  }
}
