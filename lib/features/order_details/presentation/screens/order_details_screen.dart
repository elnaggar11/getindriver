import 'package:getin_driver/core/localization/localization_helper.dart';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getin_driver/core/Router/Router.dart';
import 'package:getin_driver/core/Router/navigation_helper.dart';
import 'package:getin_driver/core/generated/images2.dart';
import 'package:getin_driver/core/theme/light_theme.dart';
import 'package:getin_driver/features/home/domain/model/order_enum.dart';
import 'package:getin_driver/features/home/domain/model/order_list_model/order_model.dart';
import 'package:getin_driver/features/home/presentation/screens/home_screen.dart';
import 'package:getin_driver/features/order_details/presentation/widgets/product_item.dart';
import 'package:getin_driver/shared/widgets/button_widget2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../cubit/order_details_cubit.dart';
import '../../cubit/order_details_states.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key, required this.orderModel});
  final OrderModel orderModel;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late OrderModel currentOrderModel;

  @override
  void initState() {
    super.initState();
    currentOrderModel = widget.orderModel;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderDetailsCubit(),
      child: BlocConsumer<OrderDetailsCubit, OrderDetailsStates>(
        listener: (context, state) {
          if (state is OrderDetailsSuccess) {
            setState(() {
              currentOrderModel = state.response!;
              print(currentOrderModel.orderStatus);
              log(
                currentOrderModel.userLocation.toString(),
                name: LocalizationHelper.tr.order_status,
              );
            });
          }
        },
        builder: (context, state) {
          final cubit = OrderDetailsCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(LocalizationHelper.tr.order_details),
              centerTitle: false,
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      DeliveryCard(orderModel: currentOrderModel),
                      const SizedBox(height: 16),
                      //MARK: - branch location
                      InkWell(
                        onTap: () {
                          var body = {
                            "location": LatLng(
                              double.parse(
                                widget.orderModel.branch?.latitude ??
                                    " 37.773606",
                              ),
                              double.parse(
                                widget.orderModel.branch?.longitude ??
                                    " -122.446116",
                              ),
                            ),
                            "order": widget.orderModel,
                          };

                          if ((widget.orderModel.orderStatus ==
                                  OrderStatus.newOrder &&
                              widget.orderModel.driver != null)) {
                            NavigationService.pushNamed(
                              Routes.mapScreen,
                              arguments: body,
                            );
                          } else {
                            NavigationService.pushNamed(
                              Routes.generalMap,
                              arguments: body,
                            );
                          }
                          print("omarr");

                          /*  if (widget.orderModel.userLocation?.first?.latitude !=
                                  null &&
                              widget.orderModel.userLocation?.first?.longitude !=
                                  null) {
                            LauncherHelper.openGoogleMaps(
                              widget.orderModel.userLocation?.first?.latitude,
                              widget.orderModel.userLocation?.first?.longitude,
                            );
                          } */
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F8F8),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 16,
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.white,
                                child: Center(
                                  child: SvgPicture.asset(
                                    SvgMang.profile,
                                    width: 13,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.orderModel.branch?.name ?? ' ',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      widget.orderModel.branch?.description ??
                                          LocalizationHelper
                                              .tr
                                              .unspecified_phrase,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const CircleAvatar(
                                radius: 24,
                                backgroundColor: LightThemeColors.primary,
                                child: Center(
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      //MARK: - client location
                      InkWell(
                        onTap: () {
                          print("omarr");
                          print(
                            "latitude ${widget.orderModel.userLocation?.latitude}",
                          );
                          print(
                            "longitude ${widget.orderModel.userLocation?.longitude}",
                          );
                          var body = {
                            "location": LatLng(
                              double.parse(
                                widget.orderModel.userLocation?.latitude ??
                                    '37.773606',
                              ),
                              double.parse(
                                widget.orderModel.userLocation?.longitude ??
                                    '-122.446116',
                              ),
                            ),
                            "order": widget.orderModel,
                          };
                          if (widget.orderModel.orderStatus ==
                                  OrderStatus.shipping ||
                              (widget.orderModel.orderStatus ==
                                      OrderStatus.newOrder &&
                                  widget.orderModel.driver != null)) {
                            NavigationService.pushNamed(
                              Routes.clientMapScreen,
                              arguments: body,
                            );
                          } else {
                            NavigationService.pushNamed(
                              Routes.generalMap,
                              arguments: body,
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F8F8),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 16,
                          ),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.white,
                                child: Center(
                                  child: Icon(
                                    Icons.location_on,
                                    color: LightThemeColors.primary,
                                    size: 30,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.orderModel.userName ?? ' ',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    widget
                                            .orderModel
                                            .userLocation
                                            ?.addressDescription ??
                                        ' ',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              const CircleAvatar(
                                radius: 24,
                                backgroundColor: LightThemeColors.primary,
                                child: Center(
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F8F8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocalizationHelper.tr.ordered_products,
                              style: TextStyle(
                                color: Color(0xFF343434),
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              LocalizationHelper.tr.item_count(
                                currentOrderModel.items?.length.toString() ??
                                    "0",
                              ),
                              style: const TextStyle(
                                color: Color(0xFF737373),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            ListView.separated(
                              itemCount: currentOrderModel.items?.length ?? 0,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ProductItem(
                                  product: currentOrderModel.items![index],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 16);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFAFAFA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              spacing: 15,
                              children: [
                                Text(
                                  LocalizationHelper.tr.subtotal,
                                  style: TextStyle(
                                    color: Color(0xFF343434),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '\$${currentOrderModel.subTotal}',
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    color: Color(0xFF343434),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Divider(
                              color: Color(0xFFF1F1F1),
                              thickness: 2,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              spacing: 15,
                              children: [
                                Text(
                                  LocalizationHelper.tr.total_order_amount,
                                  style: TextStyle(
                                    color: LightThemeColors.primary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '\$${currentOrderModel.totalPrice}',
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    color: Color(0xFF343434),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (currentOrderModel.orderStatus ==
                              OrderStatus.newOrder &&
                          currentOrderModel.driver == null)
                        GetStartedSliderButton(
                          text: LocalizationHelper.tr.confirm_order,
                          onTap: () {
                            cubit.confirmOrder(currentOrderModel.id!);
                          },
                        ),
                      if ((currentOrderModel.orderStatus ==
                                  OrderStatus.onDelivery ||
                              currentOrderModel.orderStatus ==
                                  OrderStatus.shipping) &&
                          currentOrderModel.driver?.id != null)
                        GetStartedSliderButton(
                          text: LocalizationHelper.tr.qr_reader,
                          onTap: () {
                            print(currentOrderModel.orderStatus);
                            Navigator.pushNamed(
                              context,
                              Routes.qrScanScreen,
                              arguments: currentOrderModel.id,
                            );
                          },
                        ),
                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom + 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
