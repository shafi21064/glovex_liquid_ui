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
    return CupertinoPageScaffold(
      navigationBar: const LiquidGlassTopBar(title: 'glovex_liquid_ui Demo'),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF090F2B), Color(0xFF34204E), Color(0xFF0C2B52)],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              LiquidGlassSearchBar(controller: _search),
              const SizedBox(height: 12),
              LiquidGlassProfileHeader(name: 'Kobe', email: 'kobe@example.com'),
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
                children: [
                  Expanded(
                    child: LiquidGlassStatsCard(label: 'Revenue', value: '\$12.4K', trend: '+8.1%'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: LiquidGlassStatsCard(label: 'Users', value: '3,219', trend: '+3.4%'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              LiquidGlassButton(
                label: 'Show Toast',
                leading: const Icon(CupertinoIcons.bell, color: Colors.white, size: 18),
                onPressed: () => LiquidGlassToast.show(context, 'Hello from glovex_liquid_ui'),
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
        ),
      ),
    );
  }
}
