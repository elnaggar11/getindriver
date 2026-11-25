import 'dart:developer';

import 'package:getin_driver/features/home/domain/model/order_enum.dart';

import 'item.dart';
import 'user_location.dart';

class OrderModel {
  int? id;
  String? orderNum;
  int? userId;
  String? userName;

  OrderUser? user;
  UserLocation? userLocation;
  String? status;
  OrderStatus? orderStatus;
  int? finance;
  String? createdAt;
  List<OrderItem>? items;
  String? subTotal;
  String? totalPrice;

  int? pointsIncreaseUser;
  String? driverFinance;
  String? orderReceiptTime;
  OrderBranch? branch;
  Driver? driver;

  OrderModel({
    this.id,
    this.userId,
    this.userName,
    this.userLocation,
    this.status,
    this.finance,
    this.orderStatus,
    this.createdAt,
    this.items,
    this.subTotal,
    this.totalPrice,
    this.user,
    this.branch,
    this.pointsIncreaseUser,
    this.driverFinance,
    this.orderReceiptTime,
    this.driver,
    this.orderNum,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json['id'] as int?,
    orderNum: json['order_num'] as String?,
    userId: json['user_id'] as int?,
    userName: json['user_name'] as String?,
    user: OrderUser.fromJson(json['user'] as Map<String, dynamic>),
    userLocation: json['user_location'] != null
        ? UserLocation.fromJson(json['user_location'] as Map<String, dynamic>)
        : null,
    status: json['status'] as String?,
    finance: json['finance'] as int?,
    createdAt: json['created_at'] as String?,
    items: (json['items'] as List<dynamic>?)
        ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
        .toList(),
    subTotal: json['sub_total'] as String?,
    orderStatus: orderStatusconverter(json['status'] as String?),
    totalPrice: json['total_price'] as String?,
    pointsIncreaseUser: json['points_increase_user'] as int?,
    driverFinance: json['driver_finance']?.toString(),
    orderReceiptTime: json['order_receipt_time']?.toString(),
    branch: OrderBranch.fromJson(json['branch'] as Map<String, dynamic>),
    driver: json['driver'] == null
        ? null
        : Driver.fromJson(json['driver'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'user_name': userName,
    'user_location': userLocation?.toJson(),
    'status': status,
    'finance': finance,
    'created_at': createdAt,
    'items': items?.map((e) => e.toJson()).toList(),
    'sub_total': subTotal,
    'total_price': totalPrice,
  };
}

OrderStatus orderStatusconverter(String? status) {
  log(status.toString(), name: "status");
  if (status == 'new' || status == null || status == "pending") {
    return OrderStatus.newOrder;
  } else if (status == 'in_progress' || status == 'prepared') {
    return OrderStatus.onDelivery;
  } else if (status == 'shipped') {
    return OrderStatus.shipping;
  } else if (status == 'completed') {
    return OrderStatus.delivered;
  } else {
    return OrderStatus.cancelled;
  }
}

class OrderUser {
  int? id;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  int? totalPoints;
  int? totalStars;
  String? image;

  OrderUser({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.totalPoints,
    this.totalStars,
    this.image,
  });
  OrderUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    totalPoints = json['total_points'];
    totalStars = json['total_stars'];
    image = json['image'];
  }
}

class OrderBranch {
  int? id;
  String? name;
  String? description;
  String? code;
  String? image;
  String? openingDate;
  String? closeDate;
  String? scopeWork;
  String? latitude;
  String? longitude;
  String? phoneNumber;
  num? totalRating;
  num? averageRating;
  num? totalOrders;
  bool? followed;
  String? address;
  String? deliveryTime;
  OrderBranch({
    this.id,
    this.name,
    this.description,
    this.code,
    this.image,
    this.openingDate,
    this.closeDate,
    this.scopeWork,
    this.latitude,
    this.longitude,
    this.phoneNumber,
    this.totalRating,
    this.averageRating,
    this.totalOrders,
    this.followed,
    this.address,
    this.deliveryTime,
  });

  factory OrderBranch.fromJson(Map<String, dynamic> json) => OrderBranch(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    code: json['code'],
    image: json['image'],
    openingDate: json['opening_date'],
    closeDate: json['close_date'],
    scopeWork: json['scope_work'],
    latitude: json['latitude'],
    longitude: json['longitude'],
    phoneNumber: json['phone_number'],
    totalRating: json['total_rating'],
    averageRating: json['average_rating'],
    totalOrders: json['total_orders'],
    followed: json['followed'],
    address: json['address'],
    deliveryTime: json['delivery_time'],
  );
}

class Driver {
  int? id;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  int? totalPoints;
  int? totalStars;
  String? image;
  num? range;

  Driver({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.totalPoints,
    this.totalStars,
    this.image,
    this.range,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    id: json['id'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    phoneNumber: json['phone_number'],
    totalPoints: json['total_points'],
    totalStars: json['total_stars'],
    image: json['image'],
    range: json['range'],
  );
}
