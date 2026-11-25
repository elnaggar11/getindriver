import 'order_model.dart';

class OrderListModel {
  bool? status;
  String? message;
  List<OrderModel>? data;
  int? lastPage;

  OrderListModel({this.status, this.message, this.data, this.lastPage});

  factory OrderListModel.fromJson(Map<String, dynamic> json) {
    return OrderListModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] is String || json['data'] is int)
          ? []
          : (json['data'] as List<dynamic>?)
                ?.map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
                .toList(),
      lastPage:
          json['pagination']?['last_page'] as int? ??
          json['pagination']?['lastPage'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.map((e) => e.toJson()).toList(),
    'last_page': lastPage,
  };
}
