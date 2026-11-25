import 'option.dart';

class OrderItem {
  int? id;
  int? productId;
  String? productName;
  String? productImage;
  int? quantity;
  String? totalPrice;
  List<Option>? options;
  String? price;
  String? priceAfterCoupon;
  String? totalSales;

  OrderItem({
    this.id,
    this.productId,
    this.productName,
    this.quantity,
    this.totalPrice,
    this.options,
    this.productImage,
    this.price,
    this.priceAfterCoupon,
    this.totalSales,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    id: json['id'] as int?,
    productId: json['product_id'] as int?,
    productName: json['product_name'] as String?,
    quantity: json['quantity'] as int?,
    totalPrice: json['total_price'] as String?,
    options: (json['options'] as List<dynamic>?)
        ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
        .toList(),
    productImage: json['image'] as String?,
    price: json['price']?.toString(),
    priceAfterCoupon: json['price_after_coupon']?.toString(),
    totalSales: json['total_sales']?.toString(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'product_id': productId,
    'product_name': productName,
    'quantity': quantity,
    'total_price': totalPrice,
    'options': options?.map((e) => e.toJson()).toList(),
  };
}
