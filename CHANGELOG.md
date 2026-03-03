## 1.2.0

- Added performance blur modes with global + per-widget controls:
  - `LiquidBlurMode.real` (uses `BackdropFilter`)
  - `LiquidBlurMode.fake` (no `BackdropFilter`)
  - `enableBlur` / `blurMode` support in `LiquidGlassTheme`, `LiquidGlassSurface`, and `LiquidGlassCard`
- Added repaint optimizations:
  - wrapped heavy glass rendering paths in `RepaintBoundary`
  - reduced unnecessary nested real blur in bottom-nav activator glass
- Improved list performance defaults:
  - `LiquidGlassListTile` defaults to `LiquidBlurMode.fake`
  - `LiquidGlassSection` defaults to `LiquidBlurMode.fake`
- Added `LiquidGlassTheme`-driven centralized theming across core widgets:
  - supports light/dark presets and brand tint overrides
  - centralizes blur, border, highlight, shadow, and radius behavior
- Improved button variants:
  - `primary` keeps richer glass depth
  - `ghost` now uses flatter/faster surface style (reduced blur/shadow/highlight)
- Expanded docs:
  - added performance guide (`real` vs `fake`, blur recommendations by device class, list best practices)
  - synced API tables with new blur-related parameters
- Added tests for blur behavior and kept existing router/nav tests:
  - real-blur default path
  - fake-blur path without `BackdropFilter`
  - list-friendly section default

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
