import 'package:getin_driver/features/home/domain/model/order_list_model/order_model.dart';

class FinanceModel {
  final String message;
  final List<OrderModel> orders;
  final double? totalDriverFinance;
  final ComparedMonth? comparedMonth;
  final int lastPage;

  FinanceModel({
    required this.message,
    required this.orders,
    this.totalDriverFinance,
    this.comparedMonth,
    required this.lastPage,
  });

  factory FinanceModel.fromJson(Map<String, dynamic> json) {
    List<OrderModel> ordersList = [];

    final data = json['data'];
    // Defensive parsing
    int lastPage = 1;
    if (json['pagination'] is Map) {
      final pagination = json['pagination'] as Map;
      final value = pagination['lastPage'] ?? pagination['last_page'];
      if (value != null) {
        lastPage = int.tryParse(value.toString()) ?? 1;
      }
    }

    if (data is List) {
      // Case 1: data is a list (on-delivery response)
      ordersList = data.map((e) => OrderModel.fromJson(e)).toList();
    } else if (data is Map<String, dynamic> && data['orders'] is List) {
      // Case 2: data has orders key (completed orders response)
      ordersList = (data['orders'] as List)
          .map((e) => OrderModel.fromJson(e))
          .toList();
    }

    return FinanceModel(
      message: json['message'] ?? '',
      orders: ordersList,
      totalDriverFinance: (data is Map && data['total_driver_finance'] != null)
          ? double.tryParse(data['total_driver_finance'].toString())
          : null,
      comparedMonth: (data is Map && data['compared_month'] != null)
          ? ComparedMonth.fromJson(data['compared_month'])
          : null,
      lastPage: lastPage,
    );
  }
}

class ComparedMonth {
  final double increase;
  final double percentage;

  ComparedMonth({required this.increase, required this.percentage});

  factory ComparedMonth.fromJson(Map<String, dynamic> json) {
    return ComparedMonth(
      increase: (json['increase'] as num).toDouble(),
      percentage: (json['percentage'] as num).toDouble(),
    );
  }
}
