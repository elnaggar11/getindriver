import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:getin_driver/core/resources/font_manager.dart';
import 'package:getin_driver/core/theme/light_theme.dart';

class CustomCountryCodePicker extends StatelessWidget {
  const CustomCountryCodePicker({
    super.key,
    required this.onChanged,
    this.initialSelection = '+90',
  });

  final ValueChanged<CountryCode> onChanged;
  final String initialSelection;

  @override
  Widget build(BuildContext context) {
    return CountryCodePicker(
      initialSelection: initialSelection,
      favorite: const ['+90', '+966', '+971', '+20'],
      showCountryOnly: false,
      showOnlyCountryWhenClosed: false,
      alignLeft: false,
      showFlag: true,
      padding: EdgeInsets.zero,
      showFlagDialog: true,
      onChanged: onChanged,
      builder: (country) {
        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (country?.flagUri != null)
                Image.asset(
                  country!.flagUri!,
                  package: 'country_code_picker',
                  width: 24,
                ),
              const SizedBox(width: 8),
              Text(
                country?.dialCode ?? '+90',
                style: TextStyles.font12BlackBold.copyWith(
                  color: LightThemeColors.black,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: LightThemeColors.black,
                size: 20,
              ),
              Container(
                height: 24,
                width: 1,
                margin: const EdgeInsets.only(left: 8),
                color: LightThemeColors.black.withOpacity(0.1),
              ),
            ],
          ),
        );
      },
    );
  }
}
