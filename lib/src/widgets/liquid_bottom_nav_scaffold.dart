import 'package:flutter/cupertino.dart';

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
  }) : assert(items.length == children.length,
            'items and children length must be equal.');

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<LiquidGlassBottomNavItem> items;
  final List<Widget> children;
  final bool preserveState;
  final EdgeInsetsGeometry? padding;
  final Widget? background;

  @override
  Widget build(BuildContext context) {
    final body = preserveState
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
