import 'package:flutter/material.dart';
import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:getin_driver/features/static_pages/presentaion/widgets/static_html_page_view.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StaticHtmlPageView(
      fallbackTitle: LocalizationHelper.tr.terms_and_conditions,
      onLoad: (cubit) => cubit.getTermsScreen(),
    );
  }
}
