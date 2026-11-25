import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:getin_driver/core/utils/extentions.dart';
import 'package:getin_driver/core/utils/utils.dart';
import 'package:getin_driver/features/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:getin_driver/features/auth/presentation/widgets/have_gps.dart';
import 'package:getin_driver/features/auth/presentation/widgets/sign_up_form_title.dart';

import '../../../../shared/widgets/edit_text_widget.dart';

class SignUpBody3 extends StatefulWidget {
  const SignUpBody3({super.key, this.cubit});
  final AuthCubit? cubit;
  @override
  State<SignUpBody3> createState() => _SignUpBody3State();
}

class _SignUpBody3State extends State<SignUpBody3> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.cubit?.formkey3,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
             SignUpFormTitle(title: LocalizationHelper.tr.location_details),
            15.ph,

            //CustomFilePicker(onFilePicked: (result) {}),
            TextFormFieldWidget(
              //suffixIcon: "phoelogin".svg().toSvg(),
              fixedlabel: LocalizationHelper.tr.city,
              hintText: LocalizationHelper.tr.entered_city,
              onChanged: (value) {
                widget.cubit?.registerRequestModel.city = value;
              },
              validator: Utils.valid.defaultValidation,
            ),
            40.ph,
            TextFormFieldWidget(
              fixedlabel: LocalizationHelper.tr.district_area,
              hintText: LocalizationHelper.tr.entered_district_area,
              onChanged: (value) {
                widget.cubit?.registerRequestModel.districtArea = value;
              },
              validator: Utils.valid.defaultValidation,
            ),
            40.ph,
            HaveGpsField(cubit: widget.cubit!),
            25.ph,
            TextFormFieldWidget(
              fixedlabel: LocalizationHelper.tr.additional_notes,
              hintText: LocalizationHelper.tr.extra_information,
              maxLines: 6,

              minLines: 6,
              onChanged: (value) {
                widget.cubit?.registerRequestModel.notes = value;
              },
              // ,
            ),
          ],
        ),
      ),
    );
  }
}
