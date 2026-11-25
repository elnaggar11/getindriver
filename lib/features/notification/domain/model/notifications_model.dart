// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotificationModel {
  NotificationModel({
    required this.id,
    required this.data,
    required this.isRead,
    required this.createdAt,
    // this.modelType,
    // this.modelid,
  });

  final String? id;
  final NotificationItemData? data;
  final bool? isRead;
  final String? createdAt;
  //String? modelType;
  // String? modelid;

  factory NotificationModel.fromMap(Map<String, dynamic> json) {
    return NotificationModel(
      id: json["id"]?.toString(),
      data: NotificationItemData.fromJson(json["data"]),
      isRead: json["is_read"] ?? json["seen"] ?? false,
      createdAt: json["created_at"],
      /*  // modelType: json["type"] == null
          ? null
          : (json["type"] as String).split("-").first,
      modelid: json["type"] == null
          ? null
          : (json["type"] as String).split("-").last, */
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'data': data?.toMap(),
      'isRead': isRead,
      'createdAt': createdAt,
    };
  }

  // factory NotificationModel.fromMap(Map<String, dynamic> map) {
  //   return NotificationModel(
  //     id: map['id'] != null ? map['id'] as String : null,
  //     data: map['data'] != null ? NotificationItemData.fromMap(map['data'] as Map<String,dynamic>) : null,
  //     isRead: map['isRead'] != null ? map['isRead'] as bool : null,
  //     createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
  //   );
  // }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class NotificationItemData {
  NotificationItemData({
    required this.orderId,
    required this.branchId,
    required this.message,
  });

  final String? orderId;
  final String? branchId;
  final String? message;

  factory NotificationItemData.fromJson(Map<String, dynamic> json) {
    return NotificationItemData(
      orderId: json["order_id"]?.toString(),
      branchId: json["branch_id"]?.toString(),
      message: json["message"],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'order_id': orderId,
      'branch_id': branchId,
      'message': message,
    };
  }

  factory NotificationItemData.fromMap(Map<String, dynamic> map) {
    return NotificationItemData(
      orderId: map['order_id'] != null ? map['order_id'] as String : null,
      branchId: map['branch_id'] != null ? map['branch_id'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  // factory NotificationItemData.fromJson(String source) => NotificationItemData.fromMap(json.decode(source) as Map<String, dynamic>);
}

class NotificationsPagination {
  NotificationsPagination({
    required this.lastPage,
    required this.notifications,
  });

  final int? lastPage;
  final List<NotificationModel> notifications;

  factory NotificationsPagination.fromJson(Map<String, dynamic> json) {
    return NotificationsPagination(
      lastPage: json["pagination"]?["lastPage"] ?? 1,
      // notificationsUnreadCount: json["data"]["notifications_unread_count"],
      notifications: json["data"]["data"] == null
          ? []
          : List<NotificationModel>.from(
              json["data"]["data"].map((x) => NotificationModel.fromMap(x)),
            ),
    );
  }
}
