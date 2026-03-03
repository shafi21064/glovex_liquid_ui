import 'package:flutter/material.dart';
import 'package:glovex_liquid_ui/glovex_liquid_ui.dart';

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
    this.navHeight,
    this.navMargin,
    this.navActiveColor = Colors.white,
    this.navInactiveColor,
    this.navAnimationDuration = const Duration(milliseconds: 280),
    this.navBorderRadius,
    this.navActivatorRadius,
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
    this.navHeight,
    this.navMargin,
    this.navActiveColor = Colors.white,
    this.navInactiveColor,
    this.navAnimationDuration = const Duration(milliseconds: 280),
    this.navBorderRadius,
    this.navActivatorRadius,
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
  final double? navHeight;
  final EdgeInsetsGeometry? navMargin;
  final Color navActiveColor;
  final Color? navInactiveColor;
  final Duration navAnimationDuration;
  final BorderRadius? navBorderRadius;
  final BorderRadius? navActivatorRadius;

  @override
  Widget build(BuildContext context) {
    final body = routerChild ?? _buildChildrenBody();

    return Stack(
      children: [
        if (background != null) Positioned.fill(child: background!),
        Column(
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
              height: navHeight ?? LiquidSizes.bottomNavHeight,
              margin: navMargin ?? EdgeInsets.fromLTRB(LiquidSizes.bottomNavMarginHorizontal, 0, LiquidSizes.bottomNavMarginHorizontal, LiquidSizes.bottomNavMarginBottom),
              activeColor: navActiveColor,
              inactiveColor: navInactiveColor,
              animationDuration: navAnimationDuration,
              borderRadius: navBorderRadius ?? BorderRadius.all(Radius.circular(LiquidSizes.radiusXl)),
              activatorRadius: navActivatorRadius ?? BorderRadius.all(Radius.circular(LiquidSizes.radiusLg)),
            ),
          ],
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
