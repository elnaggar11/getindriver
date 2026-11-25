class MyProfileModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  num? totalPoints;
  num? totalStars;
  num? range;
  num? totalOrdersCompleted;

  String? image;
  String? countryKey;

  MyProfileModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.totalPoints,
    this.totalStars,
    this.image,
    this.range,
    this.totalOrdersCompleted,
    this.countryKey,
  });

  factory MyProfileModel.fromJson(Map<String, dynamic> json) => MyProfileModel(
    id: json['id'] as int?,
    firstName: json['first_name'] as String?,
    lastName: json['last_name'] as String?,
    email: json['email'] as String?,
    phoneNumber: json['phone_number'] as String?,
    totalPoints: json['total_points'] as num?,
    totalStars: json['total_stars'] as num?,
    range: json['range'] as num?,
    totalOrdersCompleted: json['total_orders_completed'] as num?,
    image: json['image'] as String?,
    countryKey: json['country_key'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'first_name': firstName,
    'last_name': lastName,
    'phone_number': phoneNumber,
    'total_points': totalPoints,
    'total_stars': totalStars,
    'image': image,
    'country_key': countryKey,
  };
}
