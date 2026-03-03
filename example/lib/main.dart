import 'package:glovex_liquid_ui/glovex_liquid_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DemoApp());
}

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(home: DemoPage());
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LiquidBottomNavScaffold(
      currentIndex: _currentIndex,
      onTap: (index) => setState(() => _currentIndex = index),
      items: const [
        LiquidGlassBottomNavItem(
          icon: CupertinoIcons.house,
          activeIcon: CupertinoIcons.house_fill,
          label: 'Home',
        ),
        LiquidGlassBottomNavItem(
          icon: CupertinoIcons.person,
          activeIcon: CupertinoIcons.person_fill,
          label: 'Profile',
        ),
        LiquidGlassBottomNavItem(
          icon: CupertinoIcons.settings,
          activeIcon: CupertinoIcons.settings_solid,
          label: 'Settings',
        ),
      ],
      background: const _GradientBackground(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: const [
        _HomeTab(),
        _ProfileTab(),
        _SettingsTab(),
      ],
    );
  }
}

class _HomeTab extends StatefulWidget {
  const _HomeTab();

  @override
  State<_HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<_HomeTab> {
  final _search = TextEditingController();
  bool _switchValue = true;
  bool _checkValue = false;
  String _dropdown = 'One';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.only(top: 16, bottom: 8),
        children: [
          const LiquidGlassTopBar(title: 'glovex_liquid_ui Demo'),
          const SizedBox(height: 12),
          LiquidGlassSearchBar(controller: _search),
          const SizedBox(height: 12),
          const LiquidGlassProfileHeader(
              name: 'Kobe', email: 'kobe@example.com'),
          const SizedBox(height: 12),
          LiquidGlassSection(
            title: 'Controls',
            children: [
              LiquidGlassListTile(
                title: 'Notifications',
                trailing: LiquidGlassSwitch(
                  value: _switchValue,
                  onChanged: (v) => setState(() => _switchValue = v),
                ),
              ),
              const SizedBox(height: 8),
              LiquidGlassListTile(
                title: 'Agree Terms',
                trailing: LiquidGlassCheckbox(
                  value: _checkValue,
                  onChanged: (v) => setState(() => _checkValue = v ?? false),
                ),
              ),
              const SizedBox(height: 8),
              LiquidGlassDropdown<String>(
                value: _dropdown,
                items: const [
                  DropdownMenuItem(value: 'One', child: Text('One')),
                  DropdownMenuItem(value: 'Two', child: Text('Two')),
                ],
                onChanged: (v) => setState(() => _dropdown = v ?? 'One'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(
                child: LiquidGlassStatsCard(
                  label: 'Revenue',
                  value: '\$12.4K',
                  trend: '+8.1%',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: LiquidGlassStatsCard(
                  label: 'Users',
                  value: '3,219',
                  trend: '+3.4%',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LiquidGlassButton(
            label: 'Show Toast',
            leading:
                const Icon(CupertinoIcons.bell, color: Colors.white, size: 18),
            onPressed: () =>
                LiquidGlassToast.show(context, 'Hello from glovex_liquid_ui'),
          ),
          const SizedBox(height: 12),
          const Center(child: LiquidGlassLoader(label: 'Loading...')),
          const SizedBox(height: 24),
          const LiquidGlassEmptyState(
            title: 'No Data',
            message: 'Your list is empty. Start by adding a new item.',
          ),
        ],
      ),
    );
  }
}

class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.only(top: 16, bottom: 8),
        children: const [
          LiquidGlassTopBar(title: 'Profile'),
          SizedBox(height: 12),
          LiquidGlassProfileHeader(
            name: 'Kobe Bryant',
            email: 'kobe@example.com',
          ),
          SizedBox(height: 12),
          LiquidGlassSection(
            title: 'Account',
            children: [
              LiquidGlassListTile(
                title: 'Email',
                subtitle: 'kobe@example.com',
                leading: Icon(Icons.mail_outline),
              ),
              SizedBox(height: 8),
              LiquidGlassListTile(
                title: 'Member Since',
                subtitle: 'January 2026',
                leading: Icon(Icons.calendar_today_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingsTab extends StatelessWidget {
  const _SettingsTab();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.only(top: 16, bottom: 8),
        children: [
          const LiquidGlassTopBar(title: 'Settings'),
          const SizedBox(height: 12),
          LiquidGlassSection(
            title: 'Actions',
            children: [
              LiquidGlassListTile(
                title: 'Open Modal Sheet',
                leading: const Icon(Icons.open_in_new),
                onTap: () => LiquidGlassModalSheet.show(
                  context,
                  const Text(
                    'This is a liquid glass modal sheet.',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              LiquidGlassListTile(
                title: 'Show Toast',
                leading: const Icon(Icons.notifications_outlined),
                onTap: () => LiquidGlassToast.show(context, 'Settings saved'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GradientBackground extends StatelessWidget {
  const _GradientBackground();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF090F2B), Color(0xFF34204E), Color(0xFF0C2B52)],
        ),
      ),
      child: SizedBox.expand(),
    );
  }
}
