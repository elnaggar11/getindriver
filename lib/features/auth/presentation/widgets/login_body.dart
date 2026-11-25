import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:getin_driver/core/Router/navigation_helper.dart';
import 'package:getin_driver/core/extensions/all_extensions.dart';
import 'package:getin_driver/core/generated/images2.dart';
import 'package:getin_driver/core/resources/font_manager.dart';
import 'package:getin_driver/core/utils/extentions.dart';
import 'package:getin_driver/core/utils/utils.dart';
import 'package:getin_driver/features/auth/cubit/auth_cubit.dart';
import 'package:getin_driver/features/auth/presentation/widgets/agree_policy_privacy_widget.dart';
import 'package:flutter/material.dart';
import 'package:getin_driver/shared/widgets/custom_country_code_picker.dart';

import '../../../../core/Router/Router.dart';
import '../../../../core/theme/light_theme.dart';
import '../../../../shared/widgets/edit_text_widget.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({
    super.key,
    this.cubit,
    required this.phone,
    required this.password,
  });
  final AuthCubit? cubit;
  final TextEditingController phone;
  final TextEditingController password;
  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  String _dialCode = '+90';
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.cubit!.formkey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 3),
            TextFormFieldWidget(
              key: const Key("login_phone"),
              suffixIcon: (SvgMang.phoelogin.toSvg()),
              fixedlabel: "Phone Number *",
              validator: Utils.valid.phoneValidationByCountry(_dialCode),
              prefixWidget: CustomCountryCodePicker(
                initialSelection: '+90',
                onChanged: (country) {
                  widget.cubit?.countryKey = country.dialCode ?? '+90';
                  setState(() {
                    _dialCode = country.dialCode ?? '+90';
                  });
                },
              ),
              type: TextInputType.phone,
              controller: widget.phone,

              hintText: LocalizationHelper.tr.input_number,
            ),
            40.ph,
            TextFormFieldWidget(
              key: const Key("login_password"),
              fixedlabel: LocalizationHelper.tr.password,
              password: true,
              controller: widget.password,
              hintText: LocalizationHelper.tr.entered_password,
              // ,
            ),
            25.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AgreePolicyPrivacyWidget(
                  title: LocalizationHelper.tr.remember_me,
                ),
                Text(
                  LocalizationHelper.tr.forgot_password_link_text,
                  style: TextStyles.font12BlackBold.copyWith(
                    fontWeight: FontWeights.medium,
                    color: LightThemeColors.primary,
                  ),
                ).onTap(() {
                  Navigator.pushNamed(context, Routes.forgetPassScreen);
                }),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10,
              children: [
                Text(
                  LocalizationHelper.tr.no_account_prompt,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF5A5A5A),
                    fontSize: 14,
                    fontFamily: LocalizationHelper.tr.lama_sans,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                InkWell(
                  onTap: () {
                    NavigationService.pushNamed(Routes.registerScreen);
                  },
                  child: Text(
                    LocalizationHelper.tr.create_new_account,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF0C3B33),
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
