# glovex_liquid_ui

`glovex_liquid_ui` is a reusable Flutter UI kit for liquid-glass style apps.

## Table of Contents

- [Compatibility](#compatibility)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Bottom Navigation](#bottom-navigation)
- [Responsive System](#responsive-system)
- [Performance Guide](#performance-guide)
- [Widget Catalog](#widget-catalog)
- [Run Example](#run-example)
- [License](#license)

## Compatibility

- Dart: `>=3.3.0 <4.0.0`
- Flutter: `>=3.24.0`

## Installation

```yaml
dependencies:
  glovex_liquid_ui: ^1.2.0
```

```dart
import 'package:glovex_liquid_ui/glovex_liquid_ui.dart';
```

## Quick Start

```dart
LiquidGlassCard(
  child: const Text(
    'Hello Glass UI',
    style: TextStyle(color: Colors.white),
  ),
)
```

Recommended for best visuals:

- Use a gradient or image background behind glass widgets.
- Prefer light text/icons (`Colors.white`) on glass surfaces.
- Build complex layouts with `LiquidGlassCard` and `LiquidGlassSection`.

## Bottom Navigation

Use this when tabs are your primary app structure.

### Without Router

```dart
LiquidBottomNavScaffold(
  currentIndex: currentIndex,
  onTap: (i) => setState(() => currentIndex = i),
  items: const [
    LiquidGlassBottomNavItem(icon: CupertinoIcons.home, label: 'Home'),
    LiquidGlassBottomNavItem(icon: CupertinoIcons.person, label: 'Profile'),
    LiquidGlassBottomNavItem(icon: CupertinoIcons.settings, label: 'Settings'),
  ],
  children: const [
    HomePage(),
    ProfilePage(),
    SettingsPage(),
  ],
)
```

### With GoRouter (Recommended for starter apps)

| Widget | Key Props |
| --- | --- |
| `LiquidGlassBottomNavBar` | `currentIndex`, `items`, `onTap`, `height`, `margin` |
| `LiquidGlassBottomNavItem` | `icon`, `label`, `activeIcon` |
| `LiquidBottomNavScaffold` | `currentIndex`, `onTap`, `items`, `children`, `preserveState`, `padding`, `background`, nav style props |
| `LiquidBottomNavScaffold.router` | `currentIndex`, `onTap`, `items`, `routerChild`, `padding`, `background`, nav style props |

GoRouter helper functions for tab navigation:

- `liquidTabIndexFromLocation(...)`
- `liquidGoToTab(...)`
- `buildLiquidTabTransitionPage(...)`

```dart
final tabPaths = ['/home', '/profile', '/settings'];

ShellRoute(
  builder: (context, state, child) {
    final currentIndex = liquidTabIndexFromLocation(
      state.matchedLocation,
      tabPaths,
    );

    return LiquidBottomNavScaffold.router(
      currentIndex: currentIndex,
      onTap: (i) => liquidGoToTab(
        context: context,
        index: i,
        tabPaths: tabPaths,
      ),
      items: const [
        LiquidGlassBottomNavItem(icon: CupertinoIcons.home, label: 'Home'),
        LiquidGlassBottomNavItem(icon: CupertinoIcons.person, label: 'Profile'),
        LiquidGlassBottomNavItem(icon: CupertinoIcons.settings, label: 'Settings'),
      ],
      routerChild: child,
    );
  },
  routes: [
    GoRoute(
      path: '/home',
      pageBuilder: (_, state) => buildLiquidTabTransitionPage(
        state: state,
        child: const HomePage(),
      ),
    ),
  ],
)
```

If you need localization or custom app-level wrappers, keep a tiny shell widget and delegate rendering to `LiquidBottomNavScaffold.router`.

## Responsive System

Built-in responsive APIs:

- `context.liquidScreenType` -> `mobile`, `tablet`, `desktop`
- `context.liquidValue(...)` -> breakpoint value selection
- `context.liquidTextScale(...)` -> adaptive text scaling
- `TextStyle.liquidScale(context)` -> text style scaling
- `LiquidResponsiveBuilder` -> screen-type based UI branching
- `LiquidSizes` -> centralized app sizing/spacing scale (auto-updated by screen width)

Centralized token files:

- `lib/src/foundation/liquid_responsive_tokens.dart`
- `lib/src/foundation/glass_tokens.dart`
- `LiquidGlassTheme` via `ThemeData.extensions`

Theming example (brand tint + light/dark overrides):

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      LiquidGlassTheme.light(brandTint: const Color(0xFF5AC8FA)),
    ],
  ),
  darkTheme: ThemeData(
    brightness: Brightness.dark,
    extensions: [
      LiquidGlassTheme.dark(brandTint: const Color(0xFF7DF9FF)),
    ],
  ),
  home: const MyPage(),
)
```

Example:

```dart
final gap = context.liquidValue<double>(mobile: 8, tablet: 12, desktop: 16);
final sectionGap = LiquidSizes.sectionContentGap;
final titleStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)
    .liquidScale(context);
```

## Performance Guide

Glass blur (`BackdropFilter`) is expensive in repeated widgets. Use blur modes strategically:

- `LiquidBlurMode.real`: real backdrop blur, premium look, higher GPU cost.
- `LiquidBlurMode.fake`: no backdrop blur, uses tint/border/highlight only, much faster.

Global controls (theme):

```dart
ThemeData(
  extensions: [
    LiquidGlassTheme.dark(
      brandTint: const Color(0xFF7DF9FF),
    ).copyWith(
      enableBlur: true,
      blurMode: LiquidBlurMode.real,
      blurSigma: 12,
    ),
  ],
)
```

Per-widget overrides:

```dart
LiquidGlassCard(
  blurMode: LiquidBlurMode.fake,
  child: const Text('Fast card'),
)
```

Recommended blur by device class:

- Low-end phones: `fake` for list items, `blurSigma` around `6-8` for hero surfaces.
- Mid-range phones: `fake` in lists, `blurSigma` around `8-12` for key cards.
- Flagship phones/tablets: `real` for selected surfaces, keep list rows in `fake`.

List usage best practices:

- Prefer `LiquidGlassListTile` and `LiquidGlassSection` defaults (fake blur).
- Keep real blur to top bars, modals, and a few focus cards.
- Avoid stacking many blurred cards inside long `ListView`s.

## Widget Catalog

### Complete Export List

All package widgets/utilities included in this release:

- `LiquidGlassSurface`
- `LiquidGlassCard`
- `LiquidGlassButton`
- `LiquidGlassIconButton`
- `LiquidGlassInput`
- `LiquidGlassSearchBar`
- `LiquidGlassDropdown<T>`
- `LiquidGlassSwitch`
- `LiquidGlassCheckbox`
- `LiquidGlassRadio<T>`
- `LiquidGlassListTile`
- `LiquidGlassSection`
- `LiquidGlassEmptyState`
- `LiquidGlassProfileHeader`
- `LiquidGlassStatsCard`
- `LiquidGlassLoader`
- `LiquidGlassToast`
- `LiquidGlassModalSheet`
- `LiquidGlassTopBar`
- `LiquidGlassBottomNavBar`
- `LiquidGlassBottomNavItem`
- `LiquidBottomNavScaffold`
- `LiquidBottomNavScaffold.router`
- `LiquidResponsive`
- `LiquidResponsiveBuilder`
- `LiquidTextScaleTokens`
- `LiquidGlassTheme`
- `liquidTabIndexFromLocation(...)`
- `liquidGoToTab(...)`
- `buildLiquidTabTransitionPage(...)`

### Foundation

- `LiquidGlassSurface`: Low-level frosted surface with blur/tint/border.
- `LiquidGlassCard`: Main reusable glass container.

```dart
LiquidGlassSurface(
  borderRadius: BorderRadius.circular(20),
  padding: const EdgeInsets.all(16),
  child: const Text('Surface', style: TextStyle(color: Colors.white)),
)
```

```dart
LiquidGlassCard(
  padding: const EdgeInsets.all(16),
  child: const Text('Card', style: TextStyle(color: Colors.white)),
)
```

**API Quick Reference (Foundation)**

| Widget | Key Props |
| --- | --- |
| `LiquidGlassSurface` | `child`, `padding`, `borderRadius`, `enableBlur`, `blurMode`, `blurSigma`, `borderColor`, `backgroundColor` |
| `LiquidGlassCard` | `child`, `padding`, `borderRadius`, `height`, `width`, `margin`, `enableBlur`, `blurMode`, `blur`, `shrinkWrap` |

### Inputs and Controls

- `LiquidGlassButton`
- `LiquidGlassIconButton`
- `LiquidGlassInput`
- `LiquidGlassSearchBar`
- `LiquidGlassDropdown<T>`
- `LiquidGlassSwitch`
- `LiquidGlassCheckbox`
- `LiquidGlassRadio<T>`

```dart
LiquidGlassButton(
  label: 'Continue',
  leading: const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
  onPressed: () {},
)
```

Full-width button:

```dart
LiquidGlassButton(
  label: 'Continue',
  expanded: true,
  onPressed: () {},
)
```

```dart
LiquidGlassInput(
  controller: controller,
  placeholder: 'Enter email',
  prefix: const Icon(Icons.mail_outline, color: Colors.white),
  keyboardType: TextInputType.emailAddress,
  textInputAction: TextInputAction.done,
  onChanged: (value) {},
  onSubmitted: (value) {},
)
```

Password input with built-in visibility toggle:

```dart
LiquidGlassInput(
  controller: passwordController,
  placeholder: 'Password',
  obscureText: true,
  showPasswordToggle: true,
)
```

```dart
LiquidGlassDropdown<String>(
  value: selected,
  items: const [
    DropdownMenuItem(value: 'One', child: Text('One')),
    DropdownMenuItem(value: 'Two', child: Text('Two')),
  ],
  onChanged: (v) {},
)
```

```dart
Row(
  children: [
    LiquidGlassSwitch(value: enabled, onChanged: (v) {}),
    const SizedBox(width: 8),
    LiquidGlassCheckbox(value: checked, onChanged: (v) {}),
    const SizedBox(width: 8),
    LiquidGlassRadio<String>(
      value: 'basic',
      groupValue: selectedPlan,
      onChanged: (v) {},
    ),
  ],
)
```

**API Quick Reference (Inputs and Controls)**

| Widget | Key Props |
| --- | --- |
| `LiquidGlassButton` | `label`, `leading`, `onPressed`, `variant` (`primary`, `ghost`), `expanded`, `alignment` |
| `LiquidGlassIconButton` | `icon`, `onPressed`, `size` |
| `LiquidGlassInput` | `controller`, `placeholder`, `prefix`, `suffix`, `obscureText`, `showPasswordToggle`, `keyboardType`, `textInputAction`, `onChanged`, `onSubmitted`, `onTap` |
| `LiquidGlassSearchBar` | `controller`, `placeholder`, `onChanged` |
| `LiquidGlassDropdown<T>` | `value`, `items`, `onChanged` |
| `LiquidGlassSwitch` | `value`, `onChanged` |
| `LiquidGlassCheckbox` | `value`, `onChanged` |
| `LiquidGlassRadio<T>` | `value`, `groupValue`, `onChanged` |

### Content and Layout

- `LiquidGlassListTile`
- `LiquidGlassSection`
- `LiquidGlassEmptyState`
- `LiquidGlassProfileHeader`
- `LiquidGlassStatsCard`
- `LiquidGlassLoader`

```dart
LiquidGlassSection(
  title: 'Profile',
  subtitle: 'Welcome back',
  children: [
    LiquidGlassListTile(
      title: 'Account',
      subtitle: 'user@example.com',
      leading: const Icon(Icons.person_outline),
      onTap: () {},
    ),
  ],
)
```

```dart
const LiquidGlassProfileHeader(
  name: 'Alex Johnson',
  email: 'alex@example.com',
)
```

```dart
const LiquidGlassStatsCard(
  label: 'Revenue',
  value: '\$12.4K',
  trend: '+8.1%',
)
```

```dart
const LiquidGlassLoader(label: 'Loading...')
```

```dart
LiquidGlassEmptyState(
  title: 'No Data',
  message: 'Start by adding your first item.',
  action: LiquidGlassButton(label: 'Add Item', onPressed: () {}),
)
```

**API Quick Reference (Content and Layout)**

| Widget | Key Props |
| --- | --- |
| `LiquidGlassListTile` | `title`, `subtitle`, `leading`, `trailing`, `onTap`, `blurMode` |
| `LiquidGlassSection` | `title`, `subtitle`, `children`, `blurMode` |
| `LiquidGlassEmptyState` | `title`, `message`, `icon`, `action` |
| `LiquidGlassProfileHeader` | `name`, `email`, `avatar` |
| `LiquidGlassStatsCard` | `label`, `value`, `trend` |
| `LiquidGlassLoader` | `label` |

### Overlays and Navigation

- `LiquidGlassToast`
- `LiquidGlassModalSheet`
- `LiquidGlassTopBar`

```dart
LiquidGlassToast.show(context, 'Saved successfully');
```

```dart
await LiquidGlassModalSheet.show(
  context,
  const Text('Sheet content', style: TextStyle(color: Colors.white)),
);
```

```dart
const LiquidGlassTopBar(
  title: 'Dashboard',
  leading: Icon(CupertinoIcons.back),
  trailing: Icon(CupertinoIcons.bell),
)
```

**API Quick Reference (Overlays and Navigation)**

| Widget | Key Props |
| --- | --- |
| `LiquidGlassToast` | `show(context, message, duration)` |
| `LiquidGlassModalSheet` | `child`, `show(context, child)` |
| `LiquidGlassTopBar` | `title`, `leading`, `trailing` |

## Run Example

```bash
cd example
flutter run
```

## License

MIT
