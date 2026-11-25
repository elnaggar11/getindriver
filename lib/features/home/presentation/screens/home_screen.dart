import 'dart:async';

import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getin_driver/core/Router/Router.dart';
import 'package:getin_driver/core/extensions/all_extensions.dart';
import 'package:getin_driver/core/generated/images2.dart';
import 'package:getin_driver/core/theme/light_theme.dart';
import 'package:getin_driver/features/home/domain/model/order_enum.dart';
import 'package:getin_driver/features/home/domain/model/order_list_model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getin_driver/core/utils/utils.dart';
import 'package:getin_driver/shared/widgets/default_image_widget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../cubit/home_cubit.dart';
import '../../cubit/home_states.dart';

InputBorder borderType(BuildContext context) {
  return const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent, width: 1),
    borderRadius: BorderRadius.all(Radius.circular(30)),
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedOrderStatus = 0;
  Timer? _debounceTimer;
  final TextEditingController _searchController = TextEditingController();

  toggle(int index) {
    setState(() {
      selectedOrderStatus = index;
    });
  }

  void _onSearchChanged(String value, HomeCubit cubit) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      cubit.setSearch(value);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //  Alerts.bottomSheet(context, child: const BranchBottomSheet());
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..addPageListener(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = HomeCubit.get(context);

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      pinned: true,
                      flexibleSpace: Row(
                        children: [
                          const SizedBox(width: 40),
                          DefaultImageWidget(
                            Utils.userModel?.image ?? '',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            radius: 25,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${Utils.userModel?.firstName ?? ''} ${Utils.userModel?.lastName ?? ''}'
                                    .trim(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                LocalizationHelper.tr.best_orders,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.notificationScreen,
                                arguments: null,
                              );
                            },
                            child: CircleAvatar(
                              radius: 24,
                              backgroundColor: const Color(0xFFF8F8F8),

                              child: SvgPicture.asset(
                                SvgMang.notification,
                                width: 25,
                                height: 25,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 10)),
                    //  const SliverToBoxAdapter(child: SlideToConfirmButton()),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),

                        child: TextFormField(
                          controller: _searchController,
                          onChanged: (value) => _onSearchChanged(value, cubit),
                          decoration: InputDecoration(
                            border: borderType(context),
                            focusedBorder: borderType(context),
                            enabledBorder: borderType(context),
                            errorBorder: borderType(context),
                            hintText: LocalizationHelper.tr.order_tracking,
                            hintStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF8F8F8),

                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 3,
                                //   vertical: 12,
                              ),

                              child: SvgMang.search.toSvg(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 10)),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          spacing: 5,
                          children: List.generate(
                            OrderStatus.values.length - 1,
                            (index) => Expanded(
                              child: OrderStatusSelector(
                                orderStatus: OrderStatus.values[index],
                                isActive: index == selectedOrderStatus,
                                onTap: () {
                                  toggle(index);
                                  _searchController.clear();
                                  cubit.currentSearch = '';
                                  cubit.setOrderStatus(
                                    OrderStatus.values[index],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 10)),
                    PagedSliverList<int, OrderModel>(
                      pagingController: cubit.pagingController,
                      builderDelegate: PagedChildBuilderDelegate<OrderModel>(
                        itemBuilder: (context, item, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: DeliveryCard(
                              orderModel: item,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.orderDetailsScreen,
                                  arguments: item,
                                ).then((value) {
                                  cubit.refresh();
                                });
                              },
                            ),
                          );
                        },
                        firstPageProgressIndicatorBuilder: (context) =>
                            const Center(child: CircularProgressIndicator()),
                        newPageProgressIndicatorBuilder: (context) =>
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: CircularProgressIndicator()),
                            ),
                        noItemsFoundIndicatorBuilder: (context) => Center(
                          child: Text(
                            LocalizationHelper.tr.no_orders,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        firstPageErrorIndicatorBuilder: (context) => Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(LocalizationHelper.tr.error_occurred),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () => cubit.refresh(),
                                child: Text(LocalizationHelper.tr.retry_action),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class OrderStatusSelector extends StatelessWidget {
  const OrderStatusSelector({
    super.key,
    required this.isActive,
    required this.onTap,
    required this.orderStatus,
  });

  final bool isActive;
  final VoidCallback onTap;
  final OrderStatus orderStatus;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 8.5),
        decoration: BoxDecoration(
          //border: Border.all(color: context.primaryColor),
          color: isActive ? LightThemeColors.primary : const Color(0xffF8F8F8),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Text(
            orderStatus.name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : LightThemeColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}

class DeliveryCard extends StatelessWidget {
  const DeliveryCard({super.key, this.onTap, required this.orderModel});
  final Function()? onTap;
  final OrderModel? orderModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Top Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderModel?.orderNum ?? '#${orderModel?.id.toString()}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    orderModel?.userName ?? "cumhuriyet ( Barbaros Hayrettin )",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  //'cumhuriyet ( Barbaros Hayrettin )'
                ],
              ),
              Row(
                children: [
                  Text(
                    '\$${orderModel?.totalPrice.toString()}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: LightThemeColors.primary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: orderModel?.orderStatus?.color,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Text(
                      orderModel?.orderStatus?.nameStatus ??
                          LocalizationHelper.tr.unspecified_phrase,
                      style: TextStyle(
                        color: orderModel?.orderStatus?.colorText,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// Delivery Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(SvgMang.clock, width: 24),
                  const SizedBox(width: 4),
                  Column(
                    children: [
                      Text(
                        LocalizationHelper.tr.delivery_time,
                        style: TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 8),

                      /// MARK: Develivery time
                      Text(
                        orderModel?.branch?.deliveryTime ??
                            LocalizationHelper.tr.unspecified_phrase,
                        style: const TextStyle(
                          color: LightThemeColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SvgPicture.asset(SvgMang.between),
              Row(
                children: [
                  SvgPicture.asset(SvgMang.street, width: 24),
                  const SizedBox(width: 4),
                  Column(
                    children: [
                      Text(
                        LocalizationHelper.tr.delivery_distance_km,
                        style: TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        LocalizationHelper.tr.branch_scope_work_km(
                          orderModel?.branch?.scopeWork ?? "",
                        ),
                        style: const TextStyle(
                          color: LightThemeColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// See more button
          if (onTap != null)
            InkWell(
              onTap: onTap,
              child: Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocalizationHelper.tr.see_more,
                      style: TextStyle(
                        color: LightThemeColors.primary,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SvgPicture.asset(
                      SvgMang.arrowRight,
                      width: 16,
                      height: 16,
                      colorFilter: const ColorFilter.mode(
                        LightThemeColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class SlideToConfirmButton extends StatefulWidget {
  const SlideToConfirmButton({super.key});

  @override
  State<SlideToConfirmButton> createState() => _SlideToConfirmButtonState();
}

class _SlideToConfirmButtonState extends State<SlideToConfirmButton> {
  double dragPosition = 0;
  bool isConfirmed = false;

  double buttonWidth = 300;
  double circleSize = 40;

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      dragPosition += details.delta.dx;

      // Clamp the drag within the button
      if (dragPosition < 0) dragPosition = 0;
      if (dragPosition > buttonWidth - circleSize) {
        dragPosition = buttonWidth - circleSize;
        isConfirmed = true;
      }
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (!isConfirmed) {
      // Slide back to start if not fully dragged
      setState(() {
        dragPosition = 0;
      });
    } else {
      // Handle confirmation logic
      debugPrint(LocalizationHelper.tr.order_confirmed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF5A002B),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          // Center text and arrows
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocalizationHelper.tr.confirm_order,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(width: 10),
                Icon(Icons.chevron_right, color: Colors.white, size: 18),
                Icon(Icons.chevron_right, color: Colors.white, size: 18),
                Icon(Icons.chevron_right, color: Colors.white, size: 18),
              ],
            ),
          ),

          // Sliding circle
          Positioned(
            left: dragPosition,
            top: 5,
            child: GestureDetector(
              onHorizontalDragUpdate: _onDragUpdate,
              onHorizontalDragEnd: _onDragEnd,
              child: Container(
                width: circleSize,
                height: circleSize,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: Color(0xFF5A002B),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
