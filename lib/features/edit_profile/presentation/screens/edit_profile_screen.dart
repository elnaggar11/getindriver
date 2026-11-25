import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getin_driver/core/extensions/all_extensions.dart';
import 'package:getin_driver/core/generated/images2.dart';
import 'package:getin_driver/core/theme/light_theme.dart';
import 'package:getin_driver/core/utils/utils.dart';
import 'package:getin_driver/features/edit_profile/domain/model/edit_profile_model.dart';
import 'package:getin_driver/features/edit_profile/presentation/widgets/edit_profile_image.dart';
import 'package:getin_driver/shared/back_widget.dart';
import 'package:getin_driver/shared/widgets/colored_container.dart';
import 'package:getin_driver/shared/widgets/edit_text_widget.dart';
import 'package:flutter/services.dart';
import 'package:getin_driver/shared/widgets/custom_country_code_picker.dart';
import '../../cubit/edit_profile_cubit.dart';
import '../../cubit/edit_profile_states.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  EditProfileModel editProfileModel = EditProfileModel();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String countryKey = "+90";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit()..getProfile(),
      child: BlocConsumer<EditProfileCubit, EditProfileStates>(
        listener: (context, state) {
          if (state is GetProfileSuccessState) {
            firstNameController.text =
                state.profile.firstName ??
                LocalizationHelper.tr.unspecified_phrase;
            lastNameController.text =
                state.profile.lastName ??
                LocalizationHelper.tr.unspecified_phrase;

            String phone = state.profile.phoneNumber ?? '';
            countryKey = state.profile.countryKey ?? '+90';

            // Split consolidated phone number if necessary based on previous implementations
            if (phone.startsWith(countryKey) &&
                phone.length > countryKey.length) {
              phone = phone.substring(countryKey.length);
            }

            phoneNumberController.text = phone.isEmpty
                ? LocalizationHelper.tr.unspecified_phrase
                : phone;
            emailController.text =
                state.profile.email ?? LocalizationHelper.tr.unspecified_phrase;
            editProfileModel.countryKey = countryKey;
          }
          if (state is UpdateProfileSuccessState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          final cubit = EditProfileCubit.get(context);
          if (state is GetProfileLoadingState) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return Scaffold(
            backgroundColor: LightThemeColors.white,
            appBar: AppBar(
              leading: const BackWidget(),
              centerTitle: false,
              title: Text(
                LocalizationHelper.tr.account_info,
                style: const TextStyle(
                  color: LightThemeColors.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  const SizedBox(height: 16),
                  EditProfileImage(editProfileModel: editProfileModel),
                  const SizedBox(height: 16),

                  SizedBox(
                    height: 60,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormFieldWidget(
                            fixedlabel: 'First Name *',
                            hintText: LocalizationHelper.tr.first_name,
                            controller: firstNameController,
                            onSaved: (name) {
                              editProfileModel.firstName = name;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormFieldWidget(
                            fixedlabel: 'Last Name *',
                            hintText: LocalizationHelper.tr.last_name,
                            controller: lastNameController,
                            onSaved: (name) {
                              editProfileModel.lastName = name;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 35),
                  TextFormFieldWidget(
                    fixedlabel: 'Phone Number *',
                    hintText: LocalizationHelper.tr.input_number,
                    controller: phoneNumberController,
                    prefixWidget: CustomCountryCodePicker(
                      initialSelection: countryKey,
                      onChanged: (country) {
                        setState(() {
                          countryKey = country.dialCode ?? '+90';
                          editProfileModel.countryKey = countryKey;
                        });
                      },
                    ),
                    type: TextInputType.phone,
                    validator: Utils.valid.phoneValidationByCountry(countryKey),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onSaved: (number) {
                      editProfileModel.phoneNumber = number;
                      editProfileModel.countryKey = countryKey;
                    },
                  ),
                  const SizedBox(height: 35),
                  TextFormFieldWidget(
                    fixedlabel: 'Email *',
                    hintText: LocalizationHelper.tr.email,
                    controller: emailController,
                    suffixIcon: SvgMang.email.toSvg(),
                    onSaved: (email) {
                      editProfileModel.email = email;
                    },
                  ),
                  const SizedBox(height: 35),
                  TextFormFieldWidget(
                    fixedlabel: LocalizationHelper.tr.password,
                    hintText: LocalizationHelper.tr.entered_password,
                    controller: passwordController,
                    //   hintText: 'Enter your name',
                    onSaved: (password) {
                      editProfileModel.password = password;
                    },

                    password: true,
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      if (formKey.currentState?.validate() ?? false) {
                        formKey.currentState?.save();
                        EditProfileCubit.get(
                          context,
                        ).updateProfile(editProfileModel);
                      }
                    },
                    child: ColoredContainer(
                      height: 58,
                      color: LightThemeColors.primary,
                      child: Center(
                        child: Text(
                          LocalizationHelper.tr.save_operation,
                          style: const TextStyle(
                            color: LightThemeColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
