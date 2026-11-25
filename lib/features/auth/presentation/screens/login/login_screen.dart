import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:getin_driver/core/Router/Router.dart';
import 'package:getin_driver/core/utils/extentions.dart';
import 'package:getin_driver/features/auth/presentation/widgets/login_body.dart';
import 'package:getin_driver/shared/widgets/button_widget2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/auth_cubit.dart';
import '../../../cubit/auth_states.dart';
import '../../../domain/request/auth_request.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AuthRequest authRequest = AuthRequest();
  @override
  void dispose() {
    phone.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocProvider(
        create: (context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {
            final cubit = AuthCubit.get(context);
            if (state is VerifyOtpState) {
              Navigator.pushNamed(
                context,
                Routes.otpScreen,
                arguments: OtpArguments(
                  sendTo: phone.text,
                  onSubmit: (val) async {
                    bool? res = await AuthCubit.get(context).verifyCode(
                      code: val,
                      email: phone.text,
                      countryKey: cubit.countryKey,
                    );
                    if (res == true && context.mounted) {
                      Navigator.pushNamed(context, Routes.layoutScreen);
                    }
                  },
                  onReSend: () {
                    AuthCubit.get(context).resendCode(phone.text, cubit.countryKey);
                  },
                ),
              );
            }
            if (state is LoginSuccessState) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.layoutScreen,
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            final cubit = AuthCubit.get(context);
            return Column(
              children: [
                Expanded(
                  child: LoginBody(
                    cubit: cubit,
                    phone: phone,
                    password: password,
                  ),
                ),
                //const Spacer(),
                GetStartedSliderButton(
                  key: const Key("login_button"),

                  text: LocalizationHelper.tr.login_action,
                  onTap: () {
                    if (cubit.formkey.currentState!.validate()) {
                      cubit.login(
                        loginRequestModel: AuthRequest(
                          phone: phone.text,
                          countryKey: cubit.countryKey,
                          password: password.text,
                        ),
                      );
                    }
                  },
                ),
                74.ph,
              ],
            );
          },
        ),
      ),
    );
  }
}
