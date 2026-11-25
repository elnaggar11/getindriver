import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:getin_driver/core/generated/images2.dart';
import 'package:getin_driver/features/notification/presentation/widgets/title_and_subtitle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyNotificationsScreen extends StatelessWidget {
  const EmptyNotificationsScreen({super.key, this.ontap});
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: SvgPicture.asset(SvgMang.trash, fit: BoxFit.scaleDown),
            ),
             TitleAndSubtitleWidget(
              title: LocalizationHelper.tr.no_notifications,
              subtitle: LocalizationHelper.tr.no_current_notifications,
            ),
          ],
        ),
      ),
    );
  }
}
