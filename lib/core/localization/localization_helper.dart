import 'package:flutter/material.dart';

import '../Router/navigation_helper.dart';
import '../data_source/hive_service.dart';
import '../utils/general_constants.dart';
import 'generated/app_localizations.dart';

/// flutter gen-l10n
///To Generate Localization Files Run this command: flutter gen-l10n

class LocalizationHelper {
  LocalizationHelper._();
  static final LocalizationHelper _instance = LocalizationHelper._();
  factory LocalizationHelper() => _instance;

  static final GlobalKey<NavigatorState> _navigatorKey =
      NavigationService.navigatorKey;
  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  static AppLocalizations get tr =>
      AppLocalizations.of(navigatorKey.currentContext!);

  static const String _localeKey = 'app_locale';

  static Locale currentLocale = (() {
    try {
      final rawLocale = HiveService.getRaw(
        boxName: GeneralConstants.appBoxName,
        key: _localeKey,
      );

      return Locale(
        rawLocale ?? AppLocalizations.supportedLocales.first.languageCode,
      );
    } catch (e, s) {
      // Optionally log error
      debugPrint("Failed to load locale: $e\n$s");
      return Locale('en');
    }
  })();

  static final List<String> localNames = ['ar', 'en', 'tr'];
  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizations.delegate;

  static String get currentLocalName {
    int index = AppLocalizations.supportedLocales.indexWhere((e) {
      return e.languageCode == currentLocale.languageCode;
    });
    return localNames[index];
  }

  static bool get isArabic {
    return currentLocale.languageCode == 'ar';
  }

  static Future<void> setLocale(String languageName) async {
    int index = localNames.indexOf(languageName);
    print(index);

    await HiveService.putRaw(
      GeneralConstants.appBoxName,
      _localeKey,
      AppLocalizations.supportedLocales[index].languageCode,
    );
    LocalizationHelper.currentLocale = AppLocalizations.supportedLocales[index];
  }
}
