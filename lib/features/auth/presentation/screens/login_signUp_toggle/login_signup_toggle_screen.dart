import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:getin_driver/core/theme/light_theme.dart';
import 'package:getin_driver/core/utils/extentions.dart';
import 'package:getin_driver/features/auth/presentation/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

import '../../../../../core/resources/font_manager.dart';

class LoginSignupToggleScreen extends StatefulWidget {
  const LoginSignupToggleScreen({super.key});

  @override
  State<LoginSignupToggleScreen> createState() =>
      _LoginSignupToggleScreenState();
}

class _LoginSignupToggleScreenState extends State<LoginSignupToggleScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightThemeColors.primary,
      appBar: AppBar(
        toolbarHeight: 197,
        backgroundColor: LightThemeColors.primary,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            const Text(
              '👋',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black,
                fontSize: 27,
                fontWeight: FontWeight.w600,
              ),
            ),
            12.ph,
            Text(
              LocalizationHelper.tr.welcome_back_message,
              style: TextStyles.font18BlackBold.copyWith(
                color: LightThemeColors.white,
                fontSize: 28,
              ),
            ),
            12.ph,
            Text(
              LocalizationHelper.tr.registered_information,
              style: TextStyles.font16BlackRegular.copyWith(
                color: LightThemeColors.white,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          color: LightThemeColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.only(top: 70),
          child: LoginScreen(),
        ),
      ),
    );
  }
}
