import 'package:getin_driver/core/extensions/string_extensions.dart';
import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:getin_driver/core/extensions/widget_extensions.dart';
import 'package:getin_driver/core/generated/images2.dart';
import 'package:getin_driver/core/resources/font_manager.dart' show TextStyles;
import 'package:getin_driver/core/theme/light_theme.dart';
import 'package:getin_driver/core/utils/extentions.dart';
import 'package:getin_driver/core/utils/utils.dart';
import 'package:getin_driver/shared/widgets/button_widget.dart';
import 'package:getin_driver/shared/widgets/custom_country_code_picker.dart';
import 'package:getin_driver/shared/widgets/edit_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/Router/Router.dart';

import '../../../cubit/auth_cubit.dart';
import '../../../cubit/auth_states.dart';
import '../../../domain/request/auth_request.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  String _dialCode = '+90';
  TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AuthRequest authRequest = AuthRequest();
  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is ForgetPassSuccessState) {
            final cubit = AuthCubit.get(context);
            Navigator.pushNamed(
              context,
              Routes.otpScreen,
              arguments: OtpArguments(
                sendTo: authRequest.phone ?? "",
                onSubmit: (code) {
                  cubit
                      .verifyCode(
                        email: authRequest.phone ?? "",
                        code: code,
                        countryKey: authRequest.countryKey,
                      )
                      .then((success) {
                        if (!mounted) return;
                        if (success == true) {
                          Navigator.pushReplacementNamed(
                            context,
                            Routes.resetPasswordScreen,
                            arguments: NewPasswordArgs(
                              code: code,
                              email: authRequest.phone ?? "",
                            ),
                          );
                        }
                      });
                },
                onReSend: () {
                  cubit.forgetPass(authRequest);
                },
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = AuthCubit.get(context);
          return Scaffold(
            backgroundColor: LightThemeColors.primary,
            appBar: AppBar(
              toolbarHeight: 109,
              backgroundColor: LightThemeColors.primary,
              automaticallyImplyLeading: false,
              leading:
                  const Icon(
                    Icons.arrow_back_sharp,
                    color: LightThemeColors.white,
                  ).onTap(() {
                    Navigator.pop(context);
                  }),
            ),
            body: Container(
              decoration: const BoxDecoration(
                color: LightThemeColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      35.ph,
                      Column(
                        children: [
                          Image.asset(Assets.forgetPassIco),
                          18.5.ph,
                          Text(
                            LocalizationHelper.tr.forgot_password_link_text,
                            style: TextStyles.font18BlackBold.copyWith(
                              color: LightThemeColors.primary,
                              fontSize: 28,
                            ),
                          ),
                          15.ph,
                          SizedBox(
                            width: 312,
                            child: Text(
                              LocalizationHelper
                                  .tr
                                  .registered_phone_number_input_hint_text,
                              textAlign: TextAlign.center,
                              style: TextStyles.font16BlackRegular.copyWith(
                                color: LightThemeColors.lightgrey,
                              ),
                            ),
                          ),
                          47.ph,
                          TextFormFieldWidget(
                            controller: phoneController,
                            type: TextInputType.phone,
                            suffixIcon: (SvgMang.phoelogin.toSvg()),
                            fixedlabel: "Phone Number *",

                            prefixWidget: CustomCountryCodePicker(
                              initialSelection: '+90',
                              onChanged: (country) {
                                authRequest.countryKey =
                                    country.dialCode ?? '+90';
                                setState(() {
                                  _dialCode = country.dialCode ?? '+90';
                                });
                              },
                            ),
                            validator: Utils.valid.phoneValidationByCountry(_dialCode),
                            hintText: LocalizationHelper.tr.input_number,
                          ),
                        ],
                      ),
                      40.ph,
                      const Spacer(),
                      ButtonWidget(
                        title: LocalizationHelper.tr.get_code_action,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            authRequest.phone = phoneController.text;
                            cubit.forgetPass(authRequest);
                          }
                        },
                      ),
                      74.ph,
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
