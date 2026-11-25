import 'package:getin_driver/core/localization/localization_helper.dart';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:getin_driver/core/utils/extentions.dart';
import 'package:getin_driver/core/utils/utils.dart';
import 'package:getin_driver/features/auth/cubit/auth_cubit.dart';
import 'package:getin_driver/features/auth/domain/model/transport_model/datum.dart';
import 'package:flutter/material.dart';
import 'package:getin_driver/features/auth/presentation/widgets/sign_up_form_title.dart';
import 'package:getin_driver/shared/widgets/dropdown_bottom_sheet.dart';
import 'package:getin_driver/shared/widgets/file_picker.dart';

import '../../../../shared/widgets/edit_text_widget.dart';

class SignUpBody1 extends StatefulWidget {
  const SignUpBody1({super.key, this.cubit});
  final AuthCubit? cubit;
  @override
  State<SignUpBody1> createState() => _SignUpBody1State();
}

class _SignUpBody1State extends State<SignUpBody1> {
  TextEditingController typeOfVehicleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.cubit?.formkey1,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            15.ph,

            SignUpFormTitle(title: LocalizationHelper.tr.vehicle_information),
            15.ph,

            CustomFilePicker(
              onFilePicked: (result) {
                if (result?.files.isNotEmpty ?? false) {
                  widget
                      .cubit
                      ?.registerRequestModel
                      .vehicleRegistrationDocument = File(
                    result!.files[0].path!,
                  );
                }
              },
              //   svgIcon: "imageIcon".svg(),
              hintText: LocalizationHelper.tr.vehicle_registration_document,
              allowedExtensions: const ["pdf", "png", "jpg"],
              type: FileType.image,
            ),
            15.ph,
            CustomFilePicker(
              type: FileType.image,

              onFilePicked: (result) {
                if (result?.files.isNotEmpty ?? false) {
                  widget.cubit?.registerRequestModel.vehicleInsuranceDocument =
                      File(result!.files[0].path!);
                }
              },
              //   svgIcon: "imageIcon".svg(),
              hintText: LocalizationHelper.tr.vehicle_insurance_document,
              allowedExtensions: const ["pdf", "png", "jpg"],
            ),
            25.ph,

            ///MARK: Where is the type of vehicle?
            BottomSheetDropdownField<TransportModel>(
              label: "Type of Vehicle *",
              hintText: LocalizationHelper.tr.vehicle_type,
              displayStringForItem: (item) =>
                  item.name ?? LocalizationHelper.tr.unspecified_phrase,
              controller: typeOfVehicleController,
              fetchItems: () async {
                return widget.cubit?.getTransports() ?? [];
              },
              itemBuilder: (context, item, isSelected) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF1F1F1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        padding: const EdgeInsets.all(15),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl:
                              item.icon ??
                              LocalizationHelper.tr.unspecified_phrase,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        item.name ?? LocalizationHelper.tr.unspecified_phrase,
                      ),
                      const Spacer(),
                      Container(
                        width: 58,
                        height: 58,
                        padding: const EdgeInsets.all(15),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Icon(Icons.keyboard_arrow_right),
                      ),
                    ],
                  ),
                );
              },
              selector: (item) {
                widget.cubit?.registerRequestModel.typeOfVehicle = item.id
                    .toString();
              },

              validator: Utils.valid.defaultValidation,
              //   suffixIcon: Icon(Icons.keyboard_arrow_down),
            ),
            25.ph,

            Row(
              children: [
                Expanded(
                  child: TextFormFieldWidget(
                    fixedlabel: "Vehicle model *",
                    hintText: LocalizationHelper.tr.vehicle_model,
                    onChanged: (value) {
                      widget.cubit?.registerRequestModel.vehicleModel = value;
                    },
                    validator: Utils.valid.defaultValidation,
                  ),
                ),
                9.pw,
                Expanded(
                  child: TextFormFieldWidget(
                    fixedlabel: "Year of Manufacture *",
                    hintText: LocalizationHelper.tr.year_of_manufacture,
                    onChanged: (value) {
                      widget.cubit?.registerRequestModel.yearOfManufacture =
                          value;
                    },
                    validator: Utils.valid.defaultValidation,
                    type: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),
            25.ph,
            TextFormFieldWidget(
              fixedlabel: "License Plate Number *",
              hintText: LocalizationHelper.tr.license_plate_number,
              onChanged: (value) {
                widget.cubit?.registerRequestModel.licensePlateNumber = value;
              },
              validator: Utils.valid.defaultValidation,
            ),
            25.ph,
          ],
        ),
      ),
    );
  }
}
