# glovex_liquid_ui

`glovex_liquid_ui` is a reusable Flutter UI kit for liquid-glass style apps.

## Table of Contents

- [Compatibility](#compatibility)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Bottom Navigation](#bottom-navigation)
- [Responsive System](#responsive-system)
- [Widget Catalog](#widget-catalog)
- [Run Example](#run-example)
- [License](#license)

## Compatibility

- Dart: `>=3.3.0 <4.0.0`
- Flutter: `>=3.24.0`

## Installation

```yaml
dependencies:
  glovex_liquid_ui: ^1.1.0
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
- `context.liquidDouble(...)` -> resolve `LiquidAdaptiveDouble` tokens
- `context.liquidTextScale(...)` -> adaptive text scaling
- `TextStyle.liquidScale(context)` -> text style scaling
- `LiquidResponsiveBuilder` -> screen-type based UI branching

Centralized token files:

- `lib/src/foundation/liquid_responsive_tokens.dart`
- `lib/src/foundation/glass_tokens.dart`

Example:

```dart
final gap = context.liquidValue<double>(mobile: 8, tablet: 12, desktop: 16);
final sectionGap = context.liquidDouble(LiquidResponsiveTokens.sectionContentGap);
final titleStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)
    .liquidScale(context);
```

## Widget Catalog

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
| `LiquidGlassSurface` | `child`, `padding`, `borderRadius`, `blurSigma`, `borderColor`, `backgroundColor` |
| `LiquidGlassCard` | `child`, `padding`, `borderRadius`, `height`, `width`, `margin`, `blur`, `shrinkWrap` |

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

```dart
LiquidGlassInput(
  controller: controller,
  placeholder: 'Enter email',
  prefix: const Icon(Icons.mail_outline, color: Colors.white),
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

**API Quick Reference (Inputs and Controls)**

| Widget | Key Props |
| --- | --- |
| `LiquidGlassButton` | `label`, `leading`, `onPressed`, `variant` |
| `LiquidGlassIconButton` | `icon`, `onPressed`, `size` |
| `LiquidGlassInput` | `controller`, `placeholder`, `prefix`, `suffix`, `obscureText`, `onSubmitted` |
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

**API Quick Reference (Content and Layout)**

| Widget | Key Props |
| --- | --- |
| `LiquidGlassListTile` | `title`, `subtitle`, `leading`, `trailing`, `onTap` |
| `LiquidGlassSection` | `title`, `subtitle`, `children` |
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
