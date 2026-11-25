import 'package:getin_driver/core/localization/localization_helper.dart';
import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:getin_driver/core/extensions/all_extensions.dart';
import 'package:getin_driver/core/generated/images2.dart';
import 'package:getin_driver/core/utils/extentions.dart';
import 'package:getin_driver/core/utils/utils.dart';
import 'package:getin_driver/features/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:getin_driver/features/auth/presentation/widgets/sign_up_form_title.dart';
import 'package:getin_driver/shared/widgets/custom_country_code_picker.dart';
import 'package:getin_driver/shared/widgets/file_picker.dart';

import '../../../../shared/widgets/edit_text_widget.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key, this.cubit});
  final AuthCubit? cubit;
  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  String _dialCode = '+90';
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _idNumberController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.cubit?.formkey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            15.ph,

            SignUpFormTitle(title: LocalizationHelper.tr.personal_information),
            15.ph,

            CustomFilePicker(
              onFilePicked: (result) {
                log(result?.files[0].path ?? "ddd", name: "result");
                if (result?.files.isNotEmpty ?? false) {
                  widget.cubit?.registerRequestModel.profileImage = File(
                    result!.files[0].path!,
                  );
                }
              },
              svgIcon: SvgMang.imageIcon,
              hintText: LocalizationHelper.tr.profile_picture,
              allowedExtensions: const ["png", "jpg", "pdf"],
              type: FileType.image,
            ),
            15.ph,
            Row(
              children: [
                Expanded(
                  child: TextFormFieldWidget(
                    fixedlabel: "First Name *",
                    hintText: LocalizationHelper.tr.first_name,
                    onChanged: (value) {
                      widget.cubit?.registerRequestModel.firstName = value;
                    },
                    validator: Utils.valid.defaultValidation,
                  ),
                ),
                9.pw,
                Expanded(
                  child: TextFormFieldWidget(
                    fixedlabel: "Last Name *",
                    hintText: LocalizationHelper.tr.last_name,
                    onChanged: (value) {
                      widget.cubit?.registerRequestModel.lastName = value;
                    },
                    validator: Utils.valid.defaultValidation,
                  ),
                ),
              ],
            ),
            40.ph,
            TextFormFieldWidget(
              suffixIcon: SvgMang.phoelogin.toSvg(),
              fixedlabel: "Phone Number *",
              hintText: LocalizationHelper.tr.input_number,
              prefixWidget: CustomCountryCodePicker(
                initialSelection: '+90',
                onChanged: (country) {
                  widget.cubit?.registerRequestModel.countryKey =
                      country.dialCode ?? '+90';
                  setState(() {
                    _dialCode = country.dialCode ?? '+90';
                  });
                },
              ),
              onChanged: (value) {
                widget.cubit?.registerRequestModel.phoneNumber = value;
              },
              validator: Utils.valid.phoneValidationByCountry(_dialCode),
              type: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            40.ph,
            TextFormFieldWidget(
              fixedlabel: LocalizationHelper.tr.email_address,
              suffixIcon: SvgMang.email.toSvg(),
              onChanged: (value) {
                widget.cubit?.registerRequestModel.email = value;
              },
              validator: Utils.valid.defaultValidation,
              type: TextInputType.emailAddress,
              hintText: LocalizationHelper.tr.email,
              // ,
            ),
            40.ph,
            TextFormFieldWidget(
              fixedlabel: LocalizationHelper.tr.id_or_residence_permit,
              suffixIcon: SvgMang.id.toSvg(),
              onChanged: (value) {
                widget.cubit?.registerRequestModel.idNumber = value;
              },
              validator: Utils.valid.defaultValidation,
              type: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              hintText: LocalizationHelper.tr.entered_id_or_residence_permit,
              // ,
            ),
            40.ph,
            TextFormFieldWidget.datePicker(
              fixedlabel: LocalizationHelper.tr.date_of_birth,
              suffixIcon: SvgMang.datepicker.toSvg(),
              controller: _dateOfBirthController,
              startdate: DateTime(DateTime.now().year - 100),
              initialDate: DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
              ),
              enddate: DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
              ),
              onDateSelected: (value) {
                widget.cubit?.registerRequestModel.dateOfBirth = DateFormat(
                  'yyyy-MM-dd',
                ).format(value);
              },
              validator: Utils.valid.ageValidation,
              hintText: LocalizationHelper.tr.entered_date_of_birth,
              // ,
            ),
            40.ph,
            TextFormFieldWidget(
              fixedlabel: LocalizationHelper.tr.nationality,
              suffixIcon: SvgMang.nationality.toSvg(),
              onChanged: (value) {
                widget.cubit?.registerRequestModel.nationality = value;
              },
              validator: Utils.valid.defaultValidation,
              hintText: LocalizationHelper.tr.entered_nationality,
              // ,
            ),
            25.ph,
            TextFormFieldWidget(
              prefixIcon: SvgMang.passEye,
              fixedlabel: "password *",
              hintText: LocalizationHelper.tr.entered_password,
              onChanged: (value) {
                widget.cubit?.registerRequestModel.password = value;
              },
              password: true,
              controller: _passwordController,

              validator: (value) => Utils.valid.defaultValidation(value),
              type: TextInputType.visiblePassword,
            ),
            25.ph,
            TextFormFieldWidget(
              prefixIcon: SvgMang.passEye,
              fixedlabel: LocalizationHelper.tr.confirm_password,
              hintText: LocalizationHelper.tr.reentered_password,
              onChanged: (value) {
                widget.cubit?.registerRequestModel.confirmPassword = value;
              },
              password: true,
              controller: _confirmPasswordController,
              validator: (value) => Utils.valid.confirmPasswordValidation(
                _passwordController.text,
                value ?? LocalizationHelper.tr.unspecified_phrase,
              ),
              type: TextInputType.visiblePassword,
            ),
            25.ph,
          ],
        ),
      ),
    );
  }
}
