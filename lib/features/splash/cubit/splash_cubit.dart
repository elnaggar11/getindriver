import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getin_driver/core/generated/images2.dart';
import '../../../core/utils/Locator.dart';
import '../../../core/data_source/dio_helper.dart';
import '../domain/model/splash_model.dart';
import '../domain/repository/splash_repository.dart';
import 'splash_states.dart';

class SplashCubit extends Cubit<SplashStates> {
  SplashCubit() : super(SplashInitial());
  static SplashCubit get(context) => BlocProvider.of(context);

  SplashRepository splashRepository = SplashRepository(locator<DioService>());

  List<OnBoardingModel> onboardingModel = [
    OnBoardingModel(
      stackUrl: Assets.onboarding1,
      imageUrl: Assets.onboarding1,
      title: "Track\n your orders, \nstress-free.",
      subTitle: "Get in on the latest trends and stay ahead of the game.",
    ),
    OnBoardingModel(
      stackUrl: Assets.onboarding2,
      imageUrl: Assets.onboarding2,
      title: "Fast\n delivery,\n zero hassle.",
      subTitle:
          'Join today as a delivery partner and start earning from your very first order!',
    ),
    OnBoardingModel(
      stackUrl: Assets.onboarding3,
      imageUrl: Assets.onboarding3,
      title: "Be delivery \n hero in, \nyour area!.",
      subTitle: "AppStrings.onboardingSubtitle2",
    ),
  ];
  int sliderIndex = 0;
  late PageController controller;
  void updateSliderIndex(int index) {
    sliderIndex = index;
    emit(ChangeIntroState());
  }
}
