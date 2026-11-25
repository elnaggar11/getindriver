import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:getin_driver/core/generated/images2.dart';
import 'package:getin_driver/core/theme/light_theme.dart';
import 'package:getin_driver/core/utils/extentions.dart';
import 'package:getin_driver/features/notification/domain/model/notifications_model.dart';
import 'package:getin_driver/shared/widgets/default_image_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/font_manager.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key, required this.notificationModel});

  final NotificationModel notificationModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: LightThemeColors.darkwhite,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                //    padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: LightThemeColors.primary,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Center(
                  child: DefaultImageWidget(SvgMang.notificationIconScreen),
                ),
              ),
              Text(
                notificationModel.createdAt ?? LocalizationHelper.tr.unspecified_phrase,
                style: TextStyles.font16BlackRegular.copyWith(
                  color: LightThemeColors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          4.ph,
          Text(
            notificationModel.data?.message ?? LocalizationHelper.tr.unspecified_phrase,
            style: TextStyles.font16BlackRegular.copyWith(
              color: LightThemeColors.grey,
              fontSize: 14,
              fontWeight: FontWeights.semiBold,
            ),
          ),
          10.ph,
          Text(
            notificationModel.data?.message ?? LocalizationHelper.tr.unspecified_phrase,
            style: TextStyles.font16BlackRegular.copyWith(
              color: LightThemeColors.lightgrey,
              fontWeight: FontWeights.medium,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
