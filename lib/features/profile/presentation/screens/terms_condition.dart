import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:flutter/material.dart';

import 'package:getin_driver/core/theme/light_theme.dart';
import 'package:getin_driver/shared/back_widget.dart';

class TermsConditionScreen extends StatefulWidget {
  const TermsConditionScreen({super.key});

  @override
  State<TermsConditionScreen> createState() => _TermsConditionScreenState();
}

class _TermsConditionScreenState extends State<TermsConditionScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightThemeColors.white,
      appBar: AppBar(
        leading: const BackWidget(),
        centerTitle: false,
        title: Text(
          LocalizationHelper.tr.terms_and_conditions,
          style: TextStyle(
            color: LightThemeColors.primary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: const SingleChildScrollView(child: Column(children: [])),
    );
  }
}
