import 'dart:async';

import 'package:getin_driver/core/localization/localization_helper.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getin_driver/core/extensions/all_extensions.dart';
import 'package:getin_driver/core/generated/images2.dart';
import 'package:getin_driver/core/theme/light_theme.dart';
import 'package:getin_driver/features/home/domain/model/order_enum.dart';
import 'package:getin_driver/features/home/domain/model/order_list_model/order_model.dart';
import 'package:getin_driver/features/home/presentation/screens/home_screen.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../cubit/finance_cubit.dart';
import '../../cubit/finance_states.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  Timer? _debounceTimer;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value, FinanceCubit cubit) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      cubit.setSearch(value);
    });
  }

  FinanceStatesEnum selectedOrderStatus = FinanceStatesEnum.complete;
  toggle(BuildContext context, FinanceStatesEnum item) {
    setState(() {
      selectedOrderStatus = item;
    });
    _searchController.clear();
    FinanceCubit.get(context).currentSearch = '';
    FinanceCubit.get(context).setStatus(item.toback);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FinanceCubit()..addPageListener(),
      child: BlocConsumer<FinanceCubit, FinanceStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = FinanceCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                LocalizationHelper.tr.finance,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            /*   appBar: AppBar(
              leading: const SizedBox.shrink(),
              centerTitle: true,
              title: Text(LocalizationHelper.tr.your_evaluations),
            ), */
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomScrollView(
                slivers: <Widget>[
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
                          hintText: LocalizationHelper.tr.search_orders_hint,
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
                        spacing: 8,
                        children: [
                          ...List.generate(FinanceStatesEnum.values.length, (
                            index,
                          ) {
                            if (index == 1) {
                              return const SizedBox.shrink();
                            }
                            return Expanded(
                              child: FinanceStatusSelector(
                                financeState: FinanceStatesEnum.values[index],
                                isActive:
                                    selectedOrderStatus ==
                                    FinanceStatesEnum.values[index],
                                onTap: () => toggle(
                                  context,
                                  FinanceStatesEnum.values[index],
                                ),
                              ),
                            );
                          }),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 10)),
                  const SliverToBoxAdapter(child: SizedBox(height: 10)),
                  if (selectedOrderStatus == FinanceStatesEnum.complete)
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        // margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F8F8),
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            image: AssetImage(Assets.balanceBackgroround),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LocalizationHelper.tr.total_amounts_entered,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: LocalizationHelper.tr.lama_sans,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SvgPicture.asset(
                                  SvgMang.balanceIcon,
                                  width: 25,
                                  height: 25,
                                ),
                              ],
                            ),
                            Text(
                              '\$${cubit.financeModel?.totalDriverFinance}',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            //last rowx
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '${cubit.financeModel?.comparedMonth?.increase ?? 0}+ ',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      TextSpan(
                                        text: LocalizationHelper
                                            .tr
                                            .compared_to_last_month,
                                        style: const TextStyle(
                                          color: Color(0xFFD5E8CC),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 5,
                                  children: [
                                    const Icon(
                                      Icons.arrow_upward,
                                      color: Color(0xFFD5E8CC),
                                      size: 14,
                                    ),
                                    Text(
                                      '${cubit.financeModel?.comparedMonth?.percentage ?? 0}%',
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                        color: Color(0xFFD5E8CC),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SliverToBoxAdapter(child: SizedBox(height: 10)),

                  SliverToBoxAdapter(
                    child: Text(
                      LocalizationHelper.tr.order_history,
                      style: const TextStyle(
                        color: Color(0xFF0C3B33),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 10)),
                  PagedSliverList<int, OrderModel>(
                    pagingController: FinanceCubit.get(
                      context,
                    ).notificationsController,
                    builderDelegate: PagedChildBuilderDelegate<OrderModel>(
                      itemBuilder: (context, item, animation) {
                        return PaymentHistory(order: item);
                      },
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 110)),
                  /*    SliverAnimatedList(
                    itemBuilder: (context, index, animation) {
                      return PaymentHistory(financeState: selectedOrderStatus);
                    },
                    initialItemCount: 1000,
                  ), */
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PaymentHistory extends StatelessWidget {
  const PaymentHistory({super.key, required this.order});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            order.orderStatus?.svgPath ??
                LocalizationHelper.tr.unspecified_phrase,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.orderNum ?? '#${order.id}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    (order.orderStatus != OrderStatus.delivered)
                        ? Text(
                            order.createdAt?.substring(0, 10) ??
                                LocalizationHelper.tr.unspecified_phrase,
                            style: const TextStyle(
                              color: Color(0xFF4C4C4C),
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : Text(
                            LocalizationHelper.tr.is_completed,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Color(0xFF00964B),
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                    const SizedBox(width: 9),
                    Container(
                      width: 3,
                      height: 3,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD9D9D9),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 9),
                    Text(
                      '${order.createdAt?.substring(11, 19)}',
                      style: TextStyle(
                        color: const Color(0xFF4C4C4C),
                        fontSize: 10,
                        fontFamily: LocalizationHelper.tr.lama_sans,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (order.orderStatus != OrderStatus.cancelled) const Text('+'),
          Text(
            ' \$7.23',
            style: TextStyle(
              color: order.orderStatus?.financeColor,
              fontSize: 16,
              fontFamily: LocalizationHelper.tr.lama_sans,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

enum FinanceStatesEnum { complete, cancelled, history }

extension FinanceStatesExte on FinanceStatesEnum {
  String get name {
    switch (this) {
      case FinanceStatesEnum.complete:
        return LocalizationHelper.tr.is_complete;

      case FinanceStatesEnum.cancelled:
        return LocalizationHelper.tr.cancelled;
      case FinanceStatesEnum.history:
        return LocalizationHelper.tr.history;
      default:
        return LocalizationHelper.tr.is_complete;
    }
  }

  String get toback {
    switch (this) {
      case FinanceStatesEnum.complete:
        return "completed-orders";

      case FinanceStatesEnum.cancelled:
        return "cancelled-orders";
      case FinanceStatesEnum.history:
        return "history-orders";
    }
  }

  String get svgPath {
    switch (this) {
      case FinanceStatesEnum.complete:
        return SvgMang.addFinance;

      case FinanceStatesEnum.cancelled:
        return SvgMang.trash;
      case FinanceStatesEnum.history:
        return SvgMang.history;
    }
  }

  Color get color {
    switch (this) {
      case FinanceStatesEnum.complete:
        return LightThemeColors.primary;

      case FinanceStatesEnum.cancelled:
        return Colors.red;
      case FinanceStatesEnum.history:
        return LightThemeColors.primary;
    }
  }
}

class FinanceStatusSelector extends StatelessWidget {
  const FinanceStatusSelector({
    super.key,
    required this.isActive,
    required this.onTap,
    required this.financeState,
  });

  final FinanceStatesEnum financeState;

  final bool isActive;
  final VoidCallback onTap;

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
            financeState.name,
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
