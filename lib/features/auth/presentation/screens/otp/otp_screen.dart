import 'package:getin_driver/core/localization/localization_helper.dart';
import 'dart:async';

import 'package:getin_driver/core/generated/images2.dart';
import 'package:getin_driver/core/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';

import '../../../../../core/extensions/all_extensions.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/utils/extentions.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../shared/widgets/button_widget.dart';
import '../../../../../shared/widgets/text_widget.dart';

class OtpScreen extends StatefulWidget {
  final String sendTo;
  final Function(String code) onSubmit;
  final bool? init;
  final VoidCallback onReSend;
  const OtpScreen({
    super.key,
    required this.sendTo,
    required this.onSubmit,
    required this.onReSend,
    this.init,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final formKey = GlobalKey<FormState>();
  DateTime target = DateTime.now().add(const Duration(minutes: 5));
  bool isVerified = false;
  DateTime now = DateTime.now();
  Timer? timer;
  String remainigTime = '02:00';
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.init == true) widget.onReSend.call();
      startTimer();
    });
    super.initState();
  }

  void startTimer() {
    target = DateTime.now().add(const Duration(minutes: 2));
    now = DateTime.now();
    timer = Timer.periodic(const Duration(seconds: 1), (s) {
      if (now.isBefore(target)) {
        now = now.add(const Duration(seconds: 1));
        remainigTime =
            '${target.difference(now).inMinutes}:${target.difference(now).inSeconds.remainder(60)}';
        setState(() {});
      } else {
        remainigTime = LocalizationHelper.tr.unspecified_phrase;
        timer!.cancel();
        setState(() {});
      }
    });
  }

  TextEditingController otpController = TextEditingController();

  @override
  void dispose() {
    timer!.cancel();
    otpController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            const Icon(
              Icons.arrow_back_sharp,
              color: LightThemeColors.grey,
            ).onTap(() {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                60.ph,
                SvgPicture.asset(SvgMang.otpPhone),
                20.ph,
                Text(
                  LocalizationHelper.tr.verify_mobile_number_text,
                  style: TextStyles.font18BlackBold.copyWith(
                    color: LightThemeColors.primary,
                    fontSize: 28,
                  ),
                ),
                15.ph,
                Text(
                  LocalizationHelper.tr.verification_code_input_hint_text,
                  style: TextStyles.font18BlackRegular.copyWith(
                    color: LightThemeColors.lightgrey,
                    fontSize: 14,
                  ),
                ),
                109.ph,
                // const TextWidget(
                //   'أدخل كود التحقق الذى تم إرسالة إليك عبر البريد الالكتروني',
                //   fontSize: 14,
                //   color: Colors.black,
                //   fontWeight: FontWeight.w300,
                // ),
                // 24.ph,
                // TextWidget(
                //   widget.sendTo,
                //   fontSize: 14,
                //   color: context.primaryColor,
                //   fontWeight: FontWeight.w300,
                // ),
                // 40.ph,
                // SvgPicture.asset("otp".svg("icons"), width: 212, height: 212),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      length: 4,
                      autofocus: false,
                      cursor: Container(
                        width: 1,
                        height: 30,
                        color: LightThemeColors.primary,
                      ),
                      controller: otpController,
                      defaultPinTheme: const PinTheme(
                        textStyle: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeights.bold,
                          color: LightThemeColors.primary,
                        ),
                        width: 65.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: LightThemeColors.primary,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      followingPinTheme: const PinTheme(
                        textStyle: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeights.bold,
                          color: LightThemeColors.primary,
                        ),
                        width: 65.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: LightThemeColors.lightgrey,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      pinAnimationType: PinAnimationType.scale,
                      validator: Utils.valid.defaultValidation,
                      onCompleted: (pin) async {
                        setState(() {
                          isVerified = true;
                        });
                        await widget.onSubmit(pin);
                      },
                    ),
                  ),
                ),
                126.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      LocalizationHelper.tr.resend_code_question_text,
                      fontSize: 12,
                      color: LightThemeColors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                    8.pw,
                    16.ph,
                    remainigTime.isEmpty
                        ? GestureDetector(
                            onTap: remainigTime.isEmpty
                                ? () async {
                                    widget.onReSend.call();
                                    print('object');
                                    remainigTime = '60';
                                    setState(() {});
                                    startTimer();
                                  }
                                : null,
                            child: TextWidget(
                              LocalizationHelper.tr.resend_code_button_text,
                              fontSize: 12,
                              color: LightThemeColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : Center(
                            child: TextWidget(
                              '$remainigTime ',
                              color: context.secondaryColor,
                            ),
                          ),
                  ],
                ),
                105.ph,
                ButtonWidget(
                  title: LocalizationHelper.tr.verify_button_text,
                  buttonColor: isVerified == true
                      ? LightThemeColors.primary
                      : LightThemeColors.grey,
                  onTap: () async {
                    widget.onSubmit(otpController.text);
                  },
                ),
                16.ph,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
