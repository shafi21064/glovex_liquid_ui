import 'package:flutter/cupertino.dart';

class LiquidGlassTopBar extends StatelessWidget implements ObstructingPreferredSizeWidget {
  const LiquidGlassTopBar({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
  });

  final String title;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      backgroundColor: CupertinoColors.systemGrey.withValues(alpha: 0.2),
      middle: Text(title),
      leading: leading,
      trailing: trailing,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(44);

  @override
  bool shouldFullyObstruct(BuildContext context) => false;
}
