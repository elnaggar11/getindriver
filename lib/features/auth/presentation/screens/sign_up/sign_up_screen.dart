import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:getin_driver/core/Router/Router.dart';
import 'package:getin_driver/core/Router/navigation_helper.dart';
import 'package:getin_driver/core/services/alerts.dart';
import 'package:getin_driver/core/utils/extentions.dart';
import 'package:getin_driver/features/auth/presentation/widgets/sign_up_body1.dart';
import 'package:getin_driver/features/auth/presentation/widgets/sign_up_body2.dart';
import 'package:getin_driver/features/auth/presentation/widgets/sign_up_body3.dart';
import 'package:getin_driver/shared/widgets/button_widget2.dart';
import 'package:getin_driver/shared/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getin_driver/shared/widgets/stepper_widget.dart';

import '../../../cubit/auth_cubit.dart';
import '../../../cubit/auth_states.dart';
import '../../widgets/sign_up_body.dart' show SignUpBody;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final StepperController controller = StepperController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is VerifyRegisterSuccessState) {
            controller.nextStep();
          }
          if (state is ActivateCodeSuccessState) {
            Alerts.snack(text: state.message, state: SnackState.success);
            NavigationService.popUntil(Routes.loginSignupToggleScreen);
          }
        },
        builder: (context, state) {
          final cubit = AuthCubit.get(context);
          return Column(
            children: [
              Expanded(
                child: StepperWithController(
                  totalSteps: 4,
                  stepBuilder: (context, step) {
                    if (step == 0) {
                      return SignUpBody(cubit: cubit);
                    } else if (step == 1) {
                      return SignUpBody1(cubit: cubit);
                    } else if (step == 2) {
                      return SignUpBody2(cubit: cubit);
                    } else {
                      return SignUpBody3(cubit: cubit);
                    }
                  },
                  controller: controller,
                ),
              ),
              //   const Spacer(),
              (controller.currentStep < 3)
                  ? SizedBox(
                      width: 400,
                      //  height: 50,
                      child: ButtonWidget(
                        title: LocalizationHelper.tr.next_action,
                        onTap: () {
                          String? error = cubit.registerRequestModel.validate(
                            controller.currentStep,
                          );
                          if (error != null) {
                            Alerts.snack(text: error, state: SnackState.failed);
                            return;
                          }
                          if (cubit.validate(controller.currentStep)) {
                            cubit.verifyRegister(
                              registerRequestModel: cubit.registerRequestModel,
                              step: controller.currentStep,
                            );

                            //controller.nextStep();
                            setState(() {});
                          }
                        },
                      ),
                    )
                  : SizedBox(
                      width: 400,
                      child: GetStartedSliderButton(
                        onTap: () async {
                          if (cubit.formkey3.currentState!.validate()) {}
                          final res = await cubit.signUp(
                            registerRequestModel: cubit.registerRequestModel,
                          );
                          if (res) {
                            Navigator.pushNamed(
                              context,
                              Routes.otpScreen,
                              arguments: OtpArguments(
                                sendTo: cubit.registerRequestModel.phoneNumber!,
                                onSubmit: (val) {
                                  cubit.verifyCode(
                                    code: val,
                                    countryKey:
                                        cubit.registerRequestModel.countryKey,
                                    email:
                                        cubit.registerRequestModel.phoneNumber!,
                                  );
                                },
                                onReSend: () {
                                  cubit.resendCode(
                                    cubit.registerRequestModel.phoneNumber!,
                                    cubit.registerRequestModel.countryKey,
                                  );
                                },
                              ),
                            );
                          }
                        },
                        // witharrows: true,
                        text: LocalizationHelper.tr.start_action,
                      ),
                    ),
              74.ph,
            ],
          );
        },
      ),
    );
  }
}
