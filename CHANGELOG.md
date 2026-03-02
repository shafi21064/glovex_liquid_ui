## 1.1.1

- Documentation update: expanded README coverage to explicitly include all exported widgets, navigation APIs, and responsive helpers.
- Added missing usage snippets for key widgets (`Switch`, `Checkbox`, `Radio`, `ProfileHeader`, `StatsCard`, `Loader`, `EmptyState`, `TopBar`).
- Improved discoverability with a complete export list section.

## 1.1.0

- Added router-ready bottom nav constructor: `LiquidBottomNavScaffold.router(...)`.
- Reduced GoRouter shell boilerplate by supporting direct `routerChild` integration.
- Exposed bottom nav style controls at scaffold level:
  - `navHeight`, `navMargin`, `navActiveColor`, `navInactiveColor`
  - `navAnimationDuration`, `navBorderRadius`, `navActivatorRadius`
- Improved README bottom-navigation docs with clearer sections:
  - Without Router
  - With GoRouter (recommended for starter apps)
- Updated GoRouter README example to use `LiquidBottomNavScaffold.router(...)`.
- Added widget test coverage for router constructor rendering.

## 1.0.0

- Added bottom navigation system:
  - `LiquidGlassBottomNavBar`
  - `LiquidBottomNavScaffold`
  - GoRouter helpers in `liquid_nav_go_router.dart`
- Added responsive foundation:
  - `LiquidResponsive`, `LiquidResponsiveBuilder`
  - `LiquidResponsiveTokens` and centralized adaptive values
  - `BuildContext` responsive extensions and text scaling helpers
- Redesigned `LiquidGlassCard` with richer liquid-glass visuals:
  - layered blur and highlights
  - custom asymmetric liquid border painter
  - enhanced depth shadows
- Updated major widgets to use `LiquidGlassCard` internally for a consistent visual system.
- Fixed unbounded layout crash (`Stack requires bounded constraints`) by hardening `LiquidGlassSurface`.
- Expanded example app with tabbed bottom-nav demo (Home/Profile/Settings).
- Reworked README with improved structure and API quick reference tables.
- Updated package branding and metadata to `glovex_liquid_ui`.

## 0.1.0

- Initial release with 20 liquid-glass widgets.
- Added shared glass surface foundation.
- Added demo example app.
