import 'package:flutter/material.dart';
import 'package:getin_driver/core/theme/light_theme.dart';

class StackAppBar extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final bool centerTitle;
  final VoidCallback? onBack;
  final List<Widget>? actions;

  const StackAppBar({
    super.key,
    required this.title,
    this.backgroundColor = Colors.transparent,
    this.centerTitle = false,
    this.onBack,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: kToolbarHeight,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(color: backgroundColor),
        child: Row(
          children: [
            // Back button
            IconButton(
              icon: const Icon(Icons.arrow_back, color: LightThemeColors.black),
              onPressed: onBack ?? () => Navigator.pop(context),
            ),

            // Title
            if (centerTitle) const Spacer(),
            Text(
              title,
              style: const TextStyle(
                color: LightThemeColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            if (centerTitle) const Spacer(),

            // Actions
            if (actions != null) ...actions!,
          ],
        ),
      ),
    );
  }
}
