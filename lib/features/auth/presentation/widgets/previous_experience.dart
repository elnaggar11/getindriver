import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:getin_driver/core/utils/utils.dart';
import 'package:getin_driver/features/auth/cubit/auth_cubit.dart';
import 'package:getin_driver/features/auth/presentation/widgets/expandable_widget.dart';
import 'package:getin_driver/shared/widgets/edit_text_widget.dart';

class PreviousExperienceField extends StatefulWidget {
  const PreviousExperienceField({super.key, required this.cubit});

  final AuthCubit cubit;

  @override
  State<PreviousExperienceField> createState() =>
      _PreviousExperienceFieldState();
}

class _PreviousExperienceFieldState extends State<PreviousExperienceField> {
  bool? get _previousExperience =>
      widget.cubit.registerRequestModel.previousExperience;

  void _setExperience(bool? value) {
    widget.cubit.registerRequestModel.previousExperience = value;
    if (value != true) {
      widget.cubit.registerRequestModel.experience = null; // clear description
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpandableWidget(
          title: TextFormFieldWidget(
            fixedlabel: LocalizationHelper.tr.has_previous_experience,
            hintText: LocalizationHelper.tr.yes_no_option,
            readOnly: true,
            // Optional: auto-show Yes/No in title field
            controller: TextEditingController(
              text: _previousExperience == true
                  ? LocalizationHelper.tr.is_yes
                  : _previousExperience == false
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
                      value: _previousExperience == true,
                      onChanged: (checked) {
                        _setExperience(checked == true ? true : null);
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
                      value: _previousExperience == false,
                      onChanged: (checked) {
                        _setExperience(checked == true ? false : null);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 25),

        // Extra field if Yes is selected
        if (_previousExperience == true)
          TextFormFieldWidget(
            fixedlabel: LocalizationHelper.tr.past_experience_description,
            hintText: LocalizationHelper.tr.input_text,
            maxLines: 6,
            minLines: 6,
            onChanged: (value) {
              widget.cubit.registerRequestModel.experience = value;
            },
            // validator: Utils.valid.defaultValidation,
          ),
      ],
    );
  }
}
