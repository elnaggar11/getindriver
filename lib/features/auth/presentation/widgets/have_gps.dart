import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:getin_driver/core/utils/utils.dart';
import 'package:getin_driver/features/auth/cubit/auth_cubit.dart';
import 'package:getin_driver/features/auth/presentation/widgets/expandable_widget.dart';
import 'package:getin_driver/shared/widgets/edit_text_widget.dart';

class HaveGpsField extends StatefulWidget {
  const HaveGpsField({super.key, required this.cubit});

  final AuthCubit cubit;

  @override
  State<HaveGpsField> createState() => _HaveGpsFieldState();
}

class _HaveGpsFieldState extends State<HaveGpsField> {
  bool? get _haveGps => widget.cubit.registerRequestModel.haveGps;

  void _setHaveGps(bool? value) {
    widget.cubit.registerRequestModel.haveGps = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpandableWidget(
          title: TextFormFieldWidget(
            fixedlabel: LocalizationHelper.tr.has_gps_or_maps_installed,
            hintText: LocalizationHelper.tr.yes_no_option,
            readOnly: true,
            controller: TextEditingController(
              text: _haveGps == true
                  ? LocalizationHelper.tr.is_yes
                  : _haveGps == false
                  ? LocalizationHelper.tr.is_no
                  : LocalizationHelper.tr.unspecified_phrase,
            ),
            validator: Utils.valid.defaultValidation,
          ),
          content: Column(
            children: [
              const SizedBox(height: 10),

              // Yes option
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                decoration: ShapeDecoration(
                  color: const Color(0xFFF8F8F8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: Row(
                  children: [
                     Text(
                      LocalizationHelper.tr.is_yes,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 1.67,
                      ),
                    ),
                    const Spacer(),
                    Checkbox(
                      value: _haveGps == true,
                      onChanged: (checked) {
                        _setHaveGps(checked == true ? true : null);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // No option
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                decoration: ShapeDecoration(
                  color: const Color(0xFFF8F8F8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: Row(
                  children: [
                     Text(
                      LocalizationHelper.tr.is_no,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 1.67,
                      ),
                    ),
                    const Spacer(),
                    Checkbox(
                      value: _haveGps == false,
                      onChanged: (checked) {
                        _setHaveGps(checked == true ? false : null);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
