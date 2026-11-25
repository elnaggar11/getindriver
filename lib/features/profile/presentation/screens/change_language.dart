import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getin_driver/core/general/general_cubit.dart';

import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:getin_driver/core/theme/light_theme.dart';
import 'package:getin_driver/shared/back_widget.dart';
import 'package:getin_driver/shared/widgets/colored_container.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  String selectedLanguage = '';
  @override
  void initState() {
    super.initState();
    log(LocalizationHelper.currentLocale.languageCode, name: "language");
    selectedLanguage = LocalizationHelper.currentLocale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightThemeColors.white,
      appBar: AppBar(
        leading: const BackWidget(),
        centerTitle: false,
        title: Text(
          LocalizationHelper.tr.change_language,
          style: TextStyle(
            color: LightThemeColors.primary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: LanguageSelector(
                onLanguageSelected: (language) {
                  setState(() {
                    selectedLanguage = language;
                  });
                },
              ),
            ),
            InkWell(
              onTap: () async {
                print(selectedLanguage);
                await GeneralCubit.get(context).changeLocale(selectedLanguage);
                Navigator.pop(context);
                // Future.delayed(const Duration(milliseconds: 200), () {
                //   Navigator.pop(context);
                // });
                //   LocalizationHelper.setLocale(selectedLanguage);
              },
              child: ColoredContainer(
                height: 58,
                color: LightThemeColors.primary,
                child: Center(
                  child: Text(
                    LocalizationHelper.tr.save_operation,
                    style: TextStyle(
                      color: LightThemeColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key, required this.onLanguageSelected});
  final Function(String) onLanguageSelected;

  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  String selectedLanguage = '';

  final List<Map<String, String>> languages = [
    {'key': 'en', 'label': LocalizationHelper.tr.english},
    {'key': 'ar', 'label': LocalizationHelper.tr.arabic},
    {'key': 'tr', 'label': LocalizationHelper.tr.turkish},
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    selectedLanguage = LocalizationHelper.currentLocale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: languages
          .map(
            (language) => LanguageTile(
              language: language['label']!,
              isSelected: selectedLanguage == language['key'],
              onTap: () {
                setState(() {
                  selectedLanguage = language['key']!;
                  //   GeneralCubit.get(context).changeLocale(selectedLanguage);

                  widget.onLanguageSelected(language['key']!);
                });
              },
            ),
          )
          .toList(),
    );
  }
}

class LanguageTile extends StatelessWidget {
  final String language;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageTile({
    super.key,
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredContainer(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
      child: ListTile(
        title: Text(
          language,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        trailing: Container(
          width: 24.0,
          height: 24.0,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: isSelected ? LightThemeColors.primary : Colors.grey,
              width: 2.0,
            ),
            color: isSelected ? LightThemeColors.primary : Colors.transparent,
          ),
          child: isSelected
              ? const Icon(Icons.check, size: 16.0, color: Colors.white)
              : null,
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
