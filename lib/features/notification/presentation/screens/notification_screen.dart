import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:getin_driver/core/extensions/all_extensions.dart';
import 'package:getin_driver/core/theme/light_theme.dart';
import 'package:getin_driver/core/utils/extentions.dart';
import 'package:getin_driver/features/notification/presentation/widgets/notification_widget.dart';
import 'package:getin_driver/features/notification/cubit/notifications_cubit.dart';
import 'package:getin_driver/features/notification/cubit/notifications_states.dart';
import 'package:getin_driver/features/notification/domain/model/notifications_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/resources/font_manager.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationsCubit()..addPageListener(),
      child: BlocConsumer<NotificationsCubit, NotificationsStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading:
                  const Icon(
                    Icons.arrow_back_sharp,
                    color: LightThemeColors.primary,
                  ).onTap(() {
                    Navigator.pop(context);
                  }),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocalizationHelper.tr.notification,
                    style: TextStyles.font20WhiteSemiBold.copyWith(
                      color: LightThemeColors.primary,
                    ),
                  ),
                ],
              ),
              //     toolbarHeight: 109,
              automaticallyImplyLeading: false,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  12.ph,
                  Expanded(
                    child: PagedListView.separated(
                      pagingController: NotificationsCubit.get(
                        context,
                      ).notificationsController,
                      builderDelegate:
                          PagedChildBuilderDelegate<NotificationModel>(
                            itemBuilder: (context, item, index) {
                              return NotificationWidget(
                                notificationModel: item,
                              );
                            },
                          ),
                      separatorBuilder: (context, index) => 12.ph,
                    ),

                    /*  ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        return const NotificationWidget();
                      },
                      separatorBuilder: (context, index) => 12.ph,
                      itemCount: 6,
                    ), */
                  ),
                  20.ph,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
