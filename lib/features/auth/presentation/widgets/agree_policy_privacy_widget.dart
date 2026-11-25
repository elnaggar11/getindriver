import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:getin_driver/core/utils/extentions.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/font_manager.dart';
import '../../../../core/theme/light_theme.dart';

class AgreePolicyPrivacyWidget extends StatefulWidget {
  const AgreePolicyPrivacyWidget({super.key, this.onChange, this.title});
  final Function(bool?)? onChange;
  final String? title;
  @override
  State<AgreePolicyPrivacyWidget> createState() =>
      _AgreePolicyPrivacyWidgetState();
}

class _AgreePolicyPrivacyWidgetState extends State<AgreePolicyPrivacyWidget> {
  bool agree = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        agree = !agree;
        widget.onChange?.call(agree);
        setState(() {});
      },
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: agree == true
                  ? LightThemeColors.primary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: LightThemeColors.black),
            ),
            child: Center(
              child: agree
                  ? const Icon(
                      Icons.check,
                      size: 14,
                      color: LightThemeColors.white,
                    )
                  : const SizedBox(),
            ),
          ),
          7.pw,
          Text(
            widget.title ?? LocalizationHelper.tr.unspecified_phrase,
            style: TextStyles.font12BlackBold.copyWith(
              fontWeight: FontWeights.medium,
            ),
          ),
        ],
      ),
    );
  }
}
