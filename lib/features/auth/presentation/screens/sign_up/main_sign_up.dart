import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:getin_driver/core/theme/light_theme.dart';
import 'package:getin_driver/features/auth/presentation/screens/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';


class MainSignUpScreen extends StatefulWidget {
  const MainSignUpScreen({super.key});

  @override
  State<MainSignUpScreen> createState() => _MainSignUpScreenState();
}

class _MainSignUpScreenState extends State<MainSignUpScreen>
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        //     toolbarHeight: 197,
        backgroundColor: LightThemeColors.primary,
        automaticallyImplyLeading: false,
        title:  Text(
          LocalizationHelper.tr.sign_up_action,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Colors.white,
            fontSize: 27,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
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
        child: const Column(
          mainAxisSize: MainAxisSize.max,
          children: [Expanded(child: SignUpScreen())],
        ),
      ),
    );
  }
}
