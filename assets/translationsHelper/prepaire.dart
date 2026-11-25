import 'package:translate_gen/src/extract/exception_rules.dart';
import 'package:translate_gen/src/translate/translation_provider.dart';

final translationConfig = ExceptionRules(
  textExceptions: ['import'],
  lineExceptions: ['//'],
  contentExceptions: ['substring_to_skip'],
  folderExceptions: ['generated', 'l10n', 'core', 'cubit', 'domain'],
  extractFilter: [],
  import: [
    "import 'package:getin_driver/core/localization/localization_helper.dart';",
  ],
  key: "LocalizationHelper.tr.{key}",
  keyWithVariable: "LocalizationHelper.tr.{key}( {args})",
  translate: true,
  extractOutput: 'replace.json',
  aiKey: 'AIzaSyDxfsHHkNEjtd_EoZfL0oUuogEAVkrK7dQ',
  //if translate is true you must provide your open router key Or gemini if you show gemini
  aiModel: TranslationProvider.gemini,
);
