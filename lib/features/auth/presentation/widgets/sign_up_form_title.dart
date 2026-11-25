import 'package:flutter/material.dart';
import 'package:getin_driver/core/theme/light_theme.dart';

class SignUpFormTitle extends StatelessWidget {
  const SignUpFormTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: LightThemeColors.purple,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
