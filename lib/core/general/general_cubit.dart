import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../localization/localization_helper.dart';

part 'general_state.dart';

class GeneralCubit extends Cubit<GeneralState> {
  GeneralCubit() : super(GeneralInitial());
  static GeneralCubit get(context) => BlocProvider.of(context);

  //change app theme
  bool isLightMode = true;
  changeAppTheme() {
    isLightMode = !isLightMode;
    emit(GeneralChangeAppTheme());
  }

  Future<void> changeLocale(String localeName) async {
    if (LocalizationHelper.currentLocalName == localeName) ;
    await LocalizationHelper.setLocale(localeName);
    emit(GeneralChangeLocale(locale: LocalizationHelper.currentLocalName));
    // NavigationService.pushNamedReplaceAll();
  }

  void changeLanguage(String selectedLanguage) {}
}
