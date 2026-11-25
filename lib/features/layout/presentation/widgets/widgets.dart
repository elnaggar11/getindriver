import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:getin_driver/core/generated/images2.dart';
import 'package:getin_driver/core/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/extensions/all_extensions.dart';
import '../../../../core/utils/extentions.dart';
import '../../cubit/layout_cubit.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });
  final Function(int)? onTap;
  final int currentIndex;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],

        color: context.background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          navBarItem(SvgMang.home, LocalizationHelper.tr.home, 0, SvgMang.home),
          navBarItem(SvgMang.finance, LocalizationHelper.tr.finance, 1, SvgMang.finance),
          navBarItem(SvgMang.report, LocalizationHelper.tr.reports, 2, SvgMang.report),
          navBarItem(SvgMang.profile, LocalizationHelper.tr.profile, 3, SvgMang.profile),
        ],
      ),
    );
    // ),
  }

  Widget navBarItem(
    String path,
    String title,
    int index,
    String pathActive, {
    VoidCallback? onTap,
  }) {
    final bool isActive =
        context.read<LayoutCubit>().tabController.index == index;
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isActive ? LightThemeColors.primary : Colors.transparent,
        ),
        child: Center(
          child: InkWell(
            onTap: () {
              context.read<LayoutCubit>().changeTab(index);
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isActive
                      ? Column(
                          children: [
                            SvgPicture.asset(
                              pathActive,
                              width: 27,
                              height: 27,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                            6.ph,
                            Text(
                              title,
                              style: context.bodySmall?.copyWith(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            // TextWidget(
                            //   title,
                            //   color: context.primaryColor,
                            //   fontSize: 14,
                            //   fontWeight: FontWeight.w600,
                            // ),
                          ],
                        )
                      : Column(
                          children: [
                            SvgPicture.asset(
                              path,
                              width: 25,
                              height: 25,
                              color: context.tertiaryColor,
                            ),
                            6.ph,
                            Text(
                              title,
                              style: context.bodySmall?.copyWith(
                                color: context.tertiaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            // TextWidget(
                            //
                            //
                            //
                            // ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
