import 'package:flutter/material.dart';

import '../foundation/liquid_responsive_tokens.dart';
import 'liquid_glass_bottom_nav_bar.dart';

/// A simple shell scaffold that keeps the bottom nav fixed and only switches
/// the content area. Useful when you don't use a router.
class LiquidBottomNavScaffold extends StatelessWidget {
  /// Creates a tab scaffold for non-router apps.
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

  /// Creates a router-friendly shell using the active routed [routerChild].
  ///
  /// Use this with `ShellRoute` (for example in `go_router`).
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

  /// Active tab index.
  final int currentIndex;

  /// Called when a nav tab is tapped.
  final ValueChanged<int> onTap;

  /// Bottom navigation item definitions.
  final List<LiquidGlassBottomNavItem> items;

  /// Tab pages used by the non-router constructor.
  final List<Widget> children;

  /// Routed child used by the router constructor.
  final Widget? routerChild;

  /// Keeps non-router children alive with an [IndexedStack].
  final bool preserveState;

  /// Optional body padding above the bottom nav.
  final EdgeInsetsGeometry? padding;

  /// Optional full-screen background behind content and nav.
  final Widget? background;

  /// Custom bottom-nav height.
  final double? navHeight;

  /// External margin around the nav bar.
  final EdgeInsetsGeometry? navMargin;

  /// Color for active nav item icon/text.
  final Color navActiveColor;

  /// Color for inactive nav item icon/text.
  final Color? navInactiveColor;

  /// Duration for nav animations.
  final Duration navAnimationDuration;

  /// Custom border radius for the nav container.
  final BorderRadius? navBorderRadius;

  /// Custom border radius for the moving active capsule.
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
              margin: navMargin ??
                  EdgeInsets.fromLTRB(
                      LiquidSizes.bottomNavMarginHorizontal,
                      0,
                      LiquidSizes.bottomNavMarginHorizontal,
                      LiquidSizes.bottomNavMarginBottom),
              activeColor: navActiveColor,
              inactiveColor: navInactiveColor,
              animationDuration: navAnimationDuration,
              borderRadius: navBorderRadius ??
                  BorderRadius.all(Radius.circular(LiquidSizes.radiusXl)),
              activatorRadius: navActivatorRadius ??
                  BorderRadius.all(Radius.circular(LiquidSizes.radiusLg)),
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
