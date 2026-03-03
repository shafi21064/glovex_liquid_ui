import 'package:flutter/cupertino.dart';

import 'liquid_glass_input.dart';

class LiquidGlassSearchBar extends StatelessWidget {
  const LiquidGlassSearchBar({
    super.key,
    required this.controller,
    this.placeholder = 'Search',
    this.onChanged,
  });

  final TextEditingController controller;
  final String placeholder;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassInput(
      controller: controller,
      placeholder: placeholder,
      prefix: const Icon(CupertinoIcons.search, size: 18),
      onChanged: onChanged,
    );
  }
}
