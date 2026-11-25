import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getin_driver/core/Router/Router.dart';
import 'package:getin_driver/core/extensions/all_extensions.dart';
import 'package:getin_driver/core/generated/images2.dart';
import 'package:getin_driver/core/theme/light_theme.dart';
import 'package:getin_driver/core/utils/launcher.dart';
import 'package:getin_driver/features/home/domain/model/order_enum.dart';
import 'package:getin_driver/features/home/domain/model/order_list_model/order_model.dart';
import 'package:getin_driver/features/order_map/cubit/order_map_controller.dart';
import 'package:getin_driver/shared/widgets/button_widget.dart';

class OrderInfoCard extends StatelessWidget {
  const OrderInfoCard({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // margin: const EdgeInsets.all(12),
      //  padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: LightThemeColors.primary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top row (profile + name + actions)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(order.branch?.image ?? LocalizationHelper.tr.unspecified_phrase),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.branch?.name ?? LocalizationHelper.tr.unspecified_phrase,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: LightThemeColors.white,
                      ),
                    ),
                    Text(
                      "#${order.id ?? LocalizationHelper.tr.unspecified_phrase}",
                      style: const TextStyle(
                        color: LightThemeColors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Spacer(),

                /// Call button
                InkWell(
                  onTap: () {
                    LauncherHelper.call(order.branch?.phoneNumber ?? LocalizationHelper.tr.unspecified_phrase);
                  },
                  child: const CircleAvatar(
                    backgroundColor: LightThemeColors.white,
                    child: Icon(
                      Icons.call,
                      color: LightThemeColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                /// Message button
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.qrScanScreen,
                      arguments: order.id,
                    );
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: SvgMang.scan.toSvg(color: LightThemeColors.primary),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          ///MARK: New Order Status
          Container(
            width: double.infinity,
            // margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: LightThemeColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                /// Delivery Time
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(0xFFF8F8F8),
                      child: Icon(Icons.access_time, color: Colors.black),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(LocalizationHelper.tr.delivery_time),
                          Text(
                            order.branch?.deliveryTime ?? LocalizationHelper.tr.unspecified_phrase,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const Divider(height: 24),

                /// Address
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(0xFFF8F8F8),
                      child: Icon(Icons.location_on, color: Colors.black),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(LocalizationHelper.tr.branch_receive_address),
                          Text(
                            order.branch?.address ?? LocalizationHelper.tr.unspecified_phrase,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                ((order.orderStatus == OrderStatus.onDelivery ||
                        order.orderStatus == OrderStatus.shipping))
                    ? ButtonWidget(
                        title: LocalizationHelper.tr.is_delivered,
                        buttonColor: LightThemeColors.offWhite2,
                        textColor: LightThemeColors.black,
                        onTap: () {
                          // context.read<MapCubit>().receiveOrder(order.id!);
                        },
                      )
                    : ButtonWidget(
                        title: LocalizationHelper.tr.order_received,
                        textColor: LightThemeColors.white,
                        onTap: () {
                          context.read<MapCubit>().receiveOrder(order.id!);
                        },
                      ),
                const SizedBox(height: 16),

                /// Status Box
                /*    Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F8F8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:  Center(
                    child: Text(
                      LocalizationHelper.tr.request_received,
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ), */
              ],
            ),
          ),
        ],
      ),
    );
  }
}
