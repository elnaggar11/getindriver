import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getin_driver/core/generated/images2.dart';
import 'package:getin_driver/features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:getin_driver/features/edit_profile/domain/model/edit_profile_model.dart';
import 'package:getin_driver/shared/widgets/default_image_widget.dart';
import 'package:getin_driver/shared/widgets/image_picker_widget.dart';

class EditProfileImage extends StatelessWidget {
  const EditProfileImage({super.key, required this.editProfileModel});

  final EditProfileModel editProfileModel;

  @override
  Widget build(BuildContext context) {
    var cubit = EditProfileCubit.get(context);
    return Align(
      alignment: Alignment.center,
      child: ClipOval(
        child: CircleAvatar(
          radius: 58,
          child: ImagePickerWidget(
            initialImages:
                cubit.profile?.image ??
                "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-600nw-1714666150.jpg",
            onImageSelected: (image) {
              editProfileModel.image = image;
            },
            builder: (file, initialImages, pickImage) => Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: DefaultImageWidget(
                    file?.path ?? initialImages,
                    width: 116,
                    height: 116,
                    fit: BoxFit.cover,
                    radius: 58,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      pickImage();
                    },
                    child: Container(
                      width: 116,
                      height: 33,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          SvgMang.camera,
                          width: 16,
                          height: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
