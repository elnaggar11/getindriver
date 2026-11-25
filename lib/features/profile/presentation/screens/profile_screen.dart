import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getin_driver/core/Router/Router.dart';
import 'package:getin_driver/core/Router/navigation_helper.dart';
import 'package:getin_driver/core/generated/images2.dart';
import 'package:getin_driver/core/services/alerts.dart';
import 'package:getin_driver/core/theme/light_theme.dart';
import 'package:getin_driver/core/utils/utils.dart';
import 'package:getin_driver/features/profile/domain/model/setting_model.dart';
import 'package:getin_driver/features/profile/presentation/widgets/logout_dialog.dart';
import 'package:getin_driver/features/profile/presentation/widgets/delete_account_dialog.dart';
import 'package:getin_driver/shared/widgets/colored_container.dart';
import 'package:getin_driver/shared/widgets/default_image_widget.dart';
import '../../cubit/profile_cubit.dart';
import '../../cubit/profile_states.dart';
import 'package:share_plus/share_plus.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> shareAppLinks(SiteSettingData data, BuildContext context) async {
    // You can adjust the share text dynamically
    final String message =
        '''


Download now:
📱 Google Play: ${data.appLinkGooglePlay.isNotEmpty ? data.appLinkGooglePlay : 'Coming soon'}
🍎 App Store: ${data.appLinkAppStore.isNotEmpty ? data.appLinkAppStore : 'Coming soon'}
''';

    final box = context.findRenderObject() as RenderBox?;

    await SharePlus.instance.share(ShareParams(text: message));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getUserProfile(),
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = ProfileCubit.get(context);
          return Scaffold(
            backgroundColor: LightThemeColors.white,
            appBar: AppBar(
              backgroundColor: LightThemeColors.white,
              leading: const SizedBox.shrink(),
              centerTitle: false,
              title: Text(
                LocalizationHelper.tr.profile,
                style: const TextStyle(
                  color: LightThemeColors.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                InkWell(
                  onTap: () {
                    NavigationService.pushNamed(Routes.editProfileScreen).then((
                      value,
                    ) {
                      setState(() {});
                    });
                  },
                  child: ColoredContainer(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Row(
                      children: [
                        DefaultImageWidget(
                          Utils.userModel?.image ??
                              "https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-600nw-1714666150.jpg",
                          width: 50,
                          height: 50,
                          sourceMediaType: MediaType.image,
                          fit: BoxFit.cover,
                          radius: 25,
                          isCircle: true,
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Utils.userModel?.firstName ?? "Omar Mahmoud",
                              style: const TextStyle(
                                color: LightThemeColors.primary,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              Utils.userModel?.phoneNumber ?? '+84 37 308 5530',
                              style: const TextStyle(
                                color: Color(0xFF6F6F6F),
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: LightThemeColors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: SettingDataCol(
                        icon: SvgMang.totalOrder,
                        title: LocalizationHelper.tr.total_orders,
                        value: Utils.userModel?.totalOrdersCompleted ?? '0',
                      ),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: SettingDataCol(
                        icon: SvgMang.range,
                        title: LocalizationHelper.tr.range,
                        value: "${Utils.userModel?.range ?? ' --'}%",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SettingRowActionWidget(
                  icon: SvgMang.share,
                  title: LocalizationHelper.tr.share,
                  onTap: () async {
                    var res = await ProfileCubit.get(context).setting();
                    if (res != null && context.mounted) {
                      shareAppLinks(res, context);
                    }
                  },
                ),
                const SizedBox(height: 8),
                SettingRowActionWidget(
                  icon: SvgMang.language,
                  title: LocalizationHelper.tr.language,
                  onTap: () {
                    NavigationService.pushNamed(Routes.changeLanguageScreen);
                  },
                ),
                const SizedBox(height: 8),
                SettingRowActionWidget(
                  icon: SvgMang.terms,
                  title: LocalizationHelper.tr.terms_and_conditions,
                  onTap: () {
                    NavigationService.pushNamed(Routes.termsConditionScreen);
                  },
                ),
                const SizedBox(height: 8),
                SettingRowActionWidget(
                  icon: SvgMang.privacy,
                  title: LocalizationHelper.tr.privacy_policy,
                  onTap: () {
                    NavigationService.pushNamed(Routes.privacyPolicyScreen);
                  },
                ),
                const SizedBox(height: 8),
                SettingRowActionWidget(
                  icon: SvgMang.support,
                  title: LocalizationHelper.tr.support,
                  onTap: () {
                    NavigationService.pushNamed(Routes.support);
                  },
                ),
                const SizedBox(height: 8),
                SettingRowActionWidget(
                  icon: SvgMang.logout,
                  title: LocalizationHelper.tr.logout,
                  onTap: () {
                    Alerts.bottomSheet(context, child: const LogoutDialog());
                  },
                ),
                const SizedBox(height: 8),
                SettingRowActionWidget(
                  icon: SvgMang.trash,
                  title: LocalizationHelper.tr.delete_account,
                  textColor: Colors.red,
                  onTap: () {
                    Alerts.bottomSheet(
                      context,
                      child: const DeleteAccountDialog(),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SettingRowActionWidget extends StatelessWidget {
  const SettingRowActionWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.textColor,
  });

  final String icon;
  final String title;
  final VoidCallback onTap;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ColoredContainer(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          children: [
            DefaultImageWidget(icon),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                color: textColor ?? LightThemeColors.primary,
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, size: 18, color: textColor),
          ],
        ),
      ),
    );
  }
}

class SettingDataCol extends StatelessWidget {
  const SettingDataCol({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  final String icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ColoredContainer(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          SvgPicture.asset(icon, width: 24, height: 24),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF343434),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF0C3B33),
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
