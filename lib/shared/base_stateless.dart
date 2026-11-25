import 'package:flutter/material.dart';
import 'package:getin_driver/core/generated/images2.dart';


class BaseStateless extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavBar;
  final Widget? floatingButton;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final bool? extendBody;
  final bool? resizeToAvoidBottomInset;

  const BaseStateless({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavBar,
    this.floatingButton,
    this.extendBody,
    this.resizeToAvoidBottomInset,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return
    //  ( backgroundColor == AppColors.primary)?
    //   SafeArea(
    //     top: true,
    //     child: Scaffold(
    //       resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? false,
    //       appBar: appBar,
    //       extendBody: extendBody ?? false,
    //       floatingActionButton: floatingButton,
    //       body: SafeArea(child: body),
    //       backgroundColor: backgroundColor,
    //       bottomNavigationBar: bottomNavBar,
    //     ),
    //   ):
    Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? false,
      appBar: appBar,
      extendBody: extendBody ?? false,
      floatingActionButton: floatingButton,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.balanceBackgroround),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(child: body),
      ),
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavBar,
    );
  }
}
