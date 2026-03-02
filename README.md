# glovex_liquid_ui

`glovex_liquid_ui` is a Flutter UI kit for liquid-glass interfaces.

## Compatibility

- Dart: `>=3.3.0 <4.0.0`
- Flutter: `>=3.24.0`

## Install

```yaml
dependencies:
  glovex_liquid_ui: ^0.1.0
```

```dart
import 'package:glovex_liquid_ui/glovex_liquid_ui.dart';
```

## Best Results

- Use a colorful/dark gradient background behind glass widgets.
- Keep text/icon color light (`Colors.white`) for readability.
- Use `LiquidGlassSurface` or `LiquidGlassCard` as the base container style.

## Common Page Setup

```dart
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final searchController = TextEditingController();
  final inputController = TextEditingController();
  bool switchValue = true;
  bool checkboxValue = false;
  String dropdownValue = 'One';
  String radioValue = 'basic';
  int navIndex = 0;

  @override
  void dispose() {
    searchController.dispose();
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const LiquidGlassTopBar(title: 'Demo'),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF090F2B), Color(0xFF34204E), Color(0xFF0C2B52)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}
```

## Widgets

### 1) `LiquidGlassSurface`
Low-level frosted glass container with blur, gradient tint, border, and shadow.

```dart
LiquidGlassSurface(
  borderRadius: BorderRadius.circular(20),
  padding: const EdgeInsets.all(16),
  blurSigma: 18,
  child: const Text('Surface', style: TextStyle(color: Colors.white)),
)
```

### 2) `LiquidGlassCard`
Convenience wrapper on top of `LiquidGlassSurface`.

```dart
LiquidGlassCard(
  child: const Text('Card content', style: TextStyle(color: Colors.white)),
)
```

### 3) `LiquidGlassButton`
Glass-style button with `primary` and `ghost` variants.

```dart
LiquidGlassButton(
  label: 'Continue',
  leading: const Icon(CupertinoIcons.arrow_right, color: Colors.white, size: 18),
  variant: LiquidGlassButtonVariant.primary,
  onPressed: () {},
)
```

### 4) `LiquidGlassIconButton`
Circular glass icon button.

```dart
LiquidGlassIconButton(
  size: 44,
  icon: const Icon(CupertinoIcons.heart, color: Colors.white),
  onPressed: () {},
)
```

### 5) `LiquidGlassInput`
Glass text input with optional prefix/suffix.

```dart
LiquidGlassInput(
  controller: inputController,
  placeholder: 'Enter email',
  prefix: const Icon(CupertinoIcons.mail, color: Colors.white),
  suffix: const Icon(CupertinoIcons.check_mark, color: Colors.white),
  onSubmitted: (value) {},
)
```

### 6) `LiquidGlassSearchBar`
Search input with search icon.  
Note: current `onChanged` callback is triggered on submit (`onSubmitted`) in this version.

```dart
LiquidGlassSearchBar(
  controller: searchController,
  placeholder: 'Search products',
  onChanged: (value) {},
)
```

### 7) `LiquidGlassDropdown<T>`
Glass-styled `DropdownButton`.

```dart
LiquidGlassDropdown<String>(
  value: dropdownValue,
  items: const [
    DropdownMenuItem(value: 'One', child: Text('One')),
    DropdownMenuItem(value: 'Two', child: Text('Two')),
  ],
  onChanged: (value) => setState(() => dropdownValue = value ?? 'One'),
)
```

### 8) `LiquidGlassSwitch`
Wrapper over `CupertinoSwitch`.

```dart
LiquidGlassSwitch(
  value: switchValue,
  onChanged: (value) => setState(() => switchValue = value),
)
```

### 9) `LiquidGlassCheckbox`
Wrapper over `Checkbox`.

```dart
LiquidGlassCheckbox(
  value: checkboxValue,
  onChanged: (value) => setState(() => checkboxValue = value ?? false),
)
```

### 10) `LiquidGlassRadio<T>`
Custom circular radio control.

```dart
Row(
  children: [
    LiquidGlassRadio<String>(
      value: 'basic',
      groupValue: radioValue,
      onChanged: (value) => setState(() => radioValue = value),
    ),
    const SizedBox(width: 8),
    const Text('Basic', style: TextStyle(color: Colors.white)),
  ],
)
```

### 11) `LiquidGlassListTile`
Glass tile for settings/lists.

```dart
LiquidGlassListTile(
  title: 'Notifications',
  subtitle: 'Push and email alerts',
  leading: const Icon(CupertinoIcons.bell, color: Colors.white),
  trailing: LiquidGlassSwitch(
    value: switchValue,
    onChanged: (value) => setState(() => switchValue = value),
  ),
  onTap: () {},
)
```

### 12) `LiquidGlassSection`
Section card with title/subtitle and a list of child widgets.

```dart
LiquidGlassSection(
  title: 'Preferences',
  subtitle: 'Manage your app behavior',
  children: [
    LiquidGlassListTile(title: 'Auto sync', onTap: () {}),
    const SizedBox(height: 8),
    LiquidGlassListTile(title: 'Theme', onTap: () {}),
  ],
)
```

### 13) `LiquidGlassBottomNavBar`
Glass bottom navigation wrapper around `CupertinoTabBar`.

```dart
LiquidGlassBottomNavBar(
  currentIndex: navIndex,
  onTap: (index) => setState(() => navIndex = index),
  items: const [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.house), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: 'Profile'),
  ],
)
```

### 14) `LiquidGlassTopBar`
Top navigation bar (`CupertinoNavigationBar`) for `CupertinoPageScaffold`.

```dart
const LiquidGlassTopBar(
  title: 'Dashboard',
  leading: Icon(CupertinoIcons.back),
  trailing: Icon(CupertinoIcons.bell),
)
```

### 15) `LiquidGlassModalSheet`
Glass bottom sheet container and helper method.

```dart
await LiquidGlassModalSheet.show(
  context,
  Column(
    mainAxisSize: MainAxisSize.min,
    children: const [
      Text('Quick Actions', style: TextStyle(color: Colors.white)),
      SizedBox(height: 12),
    ],
  ),
);
```

### 16) `LiquidGlassToast`
Overlay toast helper.

```dart
LiquidGlassToast.show(
  context,
  'Saved successfully',
  duration: const Duration(seconds: 2),
);
```

### 17) `LiquidGlassLoader`
Glass loading indicator with optional text label.

```dart
const LiquidGlassLoader(label: 'Loading...')
```

### 18) `LiquidGlassEmptyState`
Empty-state block with title, message, optional icon and action.

```dart
LiquidGlassEmptyState(
  title: 'No Data',
  message: 'Start by adding your first item.',
  action: LiquidGlassButton(label: 'Add Item', onPressed: () {}),
)
```

### 19) `LiquidGlassProfileHeader`
Profile summary card with name, optional email/avatar.

```dart
const LiquidGlassProfileHeader(
  name: 'Alex Johnson',
  email: 'alex@example.com',
)
```

### 20) `LiquidGlassStatsCard`
Small metric card for dashboards.

```dart
const LiquidGlassStatsCard(
  label: 'Revenue',
  value: '\$12.4K',
  trend: '+8.1%',
)
```

## Run Example

```bash
cd example
flutter run
```

## License

MIT
