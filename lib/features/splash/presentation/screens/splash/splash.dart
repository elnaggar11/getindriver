import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:animated_widgets_flutter/widgets/opacity_animated.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getin_driver/core/generated/images2.dart';
import 'package:getin_driver/core/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getin_driver/core/utils/utils.dart';

import '../../../../../core/Router/Router.dart';
import '../../../cubit/splash_cubit.dart';
import '../../../cubit/splash_states.dart';

///// put it in routes
///  import '../../modules/splash/presentation/splash.dart';
/// static const String splashScreen = "/splashScreen";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: Scaffold(
        backgroundColor: LightThemeColors.white,
        body: BlocConsumer<SplashCubit, SplashStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: OpacityAnimatedWidget.tween(
                    opacityEnabled: 1,
                    opacityDisabled: 0,
                    duration: const Duration(milliseconds: 3000),
                    enabled: true,
                    animationFinished: (finished) async {
                      if (await Utils.getUser() != null) {
                        // User is logged in, go to main layout
                        Navigator.pushNamed(context, Routes.layoutScreen);
                      } else if (await Utils.dataManager.hasSeenOnboarding()) {
                        // User has seen onboarding but not logged in, go to login
                        Navigator.pushNamed(
                          context,
                          Routes.loginSignupToggleScreen,
                        );
                      } else {
                        // First time user, go to onboarding
                        Navigator.pushNamed(context, Routes.onboardingScreen);
                      }
                    },
                    child: SvgPicture.asset(SvgMang.logo),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  LocalizationHelper.tr.driver_details_label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: LightThemeColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
