import 'package:glovex_liquid_ui/glovex_liquid_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('exports are available', () {
    expect(LiquidGlassButton, isNotNull);
    expect(LiquidGlassCard, isNotNull);
    expect(LiquidGlassSurface, isNotNull);
  });

  testWidgets('LiquidGlassSection lays out inside centered min column',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LiquidGlassSection(
                    title: 'Profile',
                    subtitle: 'Welcome user',
                    children: const [
                      LiquidGlassListTile(
                        title: 'Profile',
                        subtitle: 'user@example.com',
                        leading: Icon(Icons.person_outline),
                      ),
                      SizedBox(height: 8),
                      LiquidGlassListTile(
                        title: 'Settings',
                        leading: Icon(Icons.settings_outlined),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pump();
    expect(tester.takeException(), isNull);
    expect(find.text('Profile'), findsWidgets);
    expect(find.text('Settings'), findsOneWidget);
  });

  testWidgets('LiquidBottomNavScaffold.router renders router child',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LiquidBottomNavScaffold.router(
          currentIndex: 0,
          onTap: (_) {},
          items: const [
            LiquidGlassBottomNavItem(icon: Icons.home_outlined, label: 'Home'),
            LiquidGlassBottomNavItem(
              icon: Icons.person_outline,
              label: 'Profile',
            ),
          ],
          routerChild: const Center(child: Text('Router Child')),
        ),
      ),
    );

    await tester.pump();
    expect(tester.takeException(), isNull);
    expect(find.text('Router Child'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });

  testWidgets('LiquidGlassCard uses real blur by default', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LiquidGlassCard(
            child: Text('Card', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );

    await tester.pump();
    expect(find.byType(BackdropFilter), findsWidgets);
  });

  testWidgets('LiquidGlassCard fake blur mode avoids BackdropFilter',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LiquidGlassCard(
            blurMode: LiquidBlurMode.fake,
            child: Text('Card', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );

    await tester.pump();
    expect(find.byType(BackdropFilter), findsNothing);
  });

  testWidgets('LiquidGlassSection defaults to fake blur for list-friendly use',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LiquidGlassSection(
            title: 'Section',
            children: [Text('Item', style: TextStyle(color: Colors.white))],
          ),
        ),
      ),
    );

    await tester.pump();
    expect(find.byType(BackdropFilter), findsNothing);
  });
}
