import 'package:flutter/material.dart';
import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:getin_driver/features/static_pages/presentaion/widgets/static_html_page_view.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StaticHtmlPageView(
      fallbackTitle: LocalizationHelper.tr.privacy_policy,
      onLoad: (cubit) => cubit.getPrivacyPolicyScreen(),
    );
  }
}
