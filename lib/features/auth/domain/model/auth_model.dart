class UserModel {
  int id;
  String firstName;
  String lastName;
  String phoneNumber;
  String image;
  String? totalOrdersCompleted;
  String? totalStars;
  String accessToken;
  String? range;
  String? totalPoints;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.image,
    required this.accessToken,
    required this.totalOrdersCompleted,
    required this.totalStars,
    required this.totalPoints,
    required this.range,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        phoneNumber: json['phone_number'],
        image: json['image'],
        accessToken: json['access_token'],
        totalOrdersCompleted: json['total_orders_completed']?.toString(),
        range: json['range']?.toString(),
        totalStars: json['total_stars']?.toString(),
        totalPoints: json['total_points']?.toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone_number'] = phoneNumber;
    data['image'] = image;
    data['access_token'] = accessToken;
    return data;
  }
}
