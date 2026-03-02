## 1.2.0

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
