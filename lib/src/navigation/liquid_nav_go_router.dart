import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Resolves active tab index from the current route location.
///
/// Uses the longest matching prefix so routes like `/settings_two`
/// don't get incorrectly matched to `/settings`.
int liquidTabIndexFromLocation(
  String location,
  List<String> tabRoots,
) {
  var bestIndex = 0;
  var bestLength = -1;

  for (var i = 0; i < tabRoots.length; i++) {
    final root = tabRoots[i];
    if (location.startsWith(root) && root.length > bestLength) {
      bestIndex = i;
      bestLength = root.length;
    }
  }

  return bestLength == -1 ? 0 : bestIndex;
}

/// Navigates to a tab route by index.
void liquidGoToTab({
  required BuildContext context,
  required int index,
  required List<String> tabPaths,
}) {
  if (index < 0 || index >= tabPaths.length) return;
  context.go(tabPaths[index]);
}

/// Standard tab-page transition to keep navigation feel consistent.
CustomTransitionPage<void> buildLiquidTabTransitionPage({
  required GoRouterState state,
  required Widget child,
  Duration duration = const Duration(milliseconds: 260),
  Duration reverseDuration = const Duration(milliseconds: 220),
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    transitionDuration: duration,
    reverseTransitionDuration: reverseDuration,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
      final slide = Tween<Offset>(
        begin: const Offset(0.02, 0),
        end: Offset.zero,
      ).animate(curved);
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(position: slide, child: child),
      );
    },
  );
}
