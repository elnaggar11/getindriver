import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:getin_driver/core/Router/Router.dart';
import 'package:getin_driver/core/theme/light_theme.dart';
import 'package:getin_driver/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getin_driver/shared/widgets/button_widget2.dart';

import '../../../cubit/splash_cubit.dart';
import '../../../cubit/splash_states.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SplashCubit()..controller = PageController(initialPage: 0),
      child: BlocConsumer<SplashCubit, SplashStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = SplashCubit.get(context);
          return Scaffold(
            backgroundColor: LightThemeColors.white,
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    cubit.onboardingModel[cubit.sliderIndex].stackUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // Progress indicator
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 20,
                      ),
                      child: Row(
                        children: List.generate(cubit.onboardingModel.length, (
                          index,
                        ) {
                          final isFilled = index <= cubit.sliderIndex;

                          return Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              height: 4,
                              decoration: BoxDecoration(
                                color: isFilled
                                    ? LightThemeColors.white
                                    : LightThemeColors.white.withValues(
                                        alpha: 0.1,
                                      ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    Expanded(
                      child: PageView.builder(
                        controller: cubit.controller,
                        onPageChanged: cubit.updateSliderIndex,
                        itemCount: cubit.onboardingModel.length,
                        itemBuilder: (context, index) {
                          final model = cubit.onboardingModel[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              //  Image.asset(model.stackUrl, height: 220),
                              const SizedBox(height: 32),
                              //  Image.asset(model.imageUrl, height: 100),
                              const SizedBox(height: 32),
                              Text(
                                model.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 52,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 3.12,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: 16),
                              /*     Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 13.0,
                                ),
                                child: Text(
                                  model.subTitle,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    height: 2.33,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                           */
                            ],
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: GetStartedSliderButton(
                        text:
                            cubit.sliderIndex ==
                                cubit.onboardingModel.length - 1
                            ? LocalizationHelper.tr.get_started_label
                            : LocalizationHelper.tr.next_label,
                        onTap: () async {
                          if (cubit.sliderIndex <
                              cubit.onboardingModel.length - 1) {
                            cubit.controller.nextPage(
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            // Mark onboarding as seen so it won't show again
                            await Utils.dataManager.setOnboardingSeen();
                            Navigator.pushNamed(
                              context,
                              Routes.loginSignupToggleScreen,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
