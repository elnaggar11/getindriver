import 'package:flutter/material.dart';
import 'package:getin_driver/core/localization/localization_helper.dart';

class FlipAr extends StatelessWidget {
  const FlipAr({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (LocalizationHelper.isArabic) {
      return Transform.flip(flipX: true, child: child);
    }
    return child;
  }
}
