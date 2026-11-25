import 'package:getin_driver/core/localization/localization_helper.dart';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:getin_driver/core/utils/extentions.dart';
import 'package:getin_driver/features/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:getin_driver/features/auth/presentation/widgets/previous_experience.dart';
import 'package:getin_driver/features/auth/presentation/widgets/sign_up_form_title.dart';
import 'package:getin_driver/shared/widgets/file_picker.dart';

import '../../../../shared/widgets/edit_text_widget.dart';

class SignUpBody2 extends StatefulWidget {
  const SignUpBody2({super.key, this.cubit});
  final AuthCubit? cubit;
  @override
  State<SignUpBody2> createState() => _SignUpBody2State();
}

class _SignUpBody2State extends State<SignUpBody2> {
  TextEditingController previousExperience = TextEditingController();
  TextEditingController licenseIssueDate = TextEditingController();
  TextEditingController licenseExpiryDate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.cubit?.formkey2,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SignUpFormTitle(
              title: LocalizationHelper.tr.driving_license_information,
            ),
            15.ph,
            CustomFilePicker(
              onFilePicked: (result) {
                if (result?.files.isNotEmpty ?? false) {
                  widget.cubit?.registerRequestModel.drivingLicensePhoto = File(
                    result!.files[0].path!,
                  );
                }
              },
              //   svgIcon: "imageIcon".svg(),
              hintText: LocalizationHelper.tr.driving_license_photo,
              allowedExtensions: const ["pdf", "png", "jpg"],
              type: FileType.image,
            ),
            15.ph,
            TextFormFieldWidget.datePicker(
              //  suffixIcon: "phoelogin".svg().toSvg(),
              fixedlabel: "License Issue Date *",
              hintText: LocalizationHelper.tr.license_issue_date,
              controller: licenseIssueDate,
              onDateSelected: (value) {
                widget.cubit?.registerRequestModel.licenseIssueDate =
                    DateFormat('yyyy-MM-dd').format(value);
              },
            ),
            15.ph,
            TextFormFieldWidget.datePicker(
              //  suffixIcon: "phoelogin".svg().toSvg(),
              fixedlabel: "License Expiry Date *",
              hintText: LocalizationHelper.tr.license_expiry_date,
              controller: licenseExpiryDate,
              onDateSelected: (value) {
                widget.cubit?.registerRequestModel.licenseExpiryDate =
                    DateFormat('yyyy-MM-dd').format(value);
              },
            ),
            15.ph,
            //  40.ph,
            PreviousExperienceField(cubit: widget.cubit!),
          ],
        ),
      ),
    );
  }
}
