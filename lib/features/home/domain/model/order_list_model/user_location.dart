class UserLocation {
  int? id;
  String? nameAddress;
  String? buildingNumber;
  String? floor;
  String? apartment;
  String? addressDescription;
  String? addressTitle;
  String? latitude;
  String? longitude;
  String? firstName;
  String? lastName;
  String? phoneNumber;

  UserLocation({
    this.id,
    this.nameAddress,
    this.buildingNumber,
    this.floor,
    this.apartment,
    this.addressDescription,
    this.addressTitle,
    this.latitude,
    this.longitude,
    this.firstName,
    this.lastName,
    this.phoneNumber,
  });

  factory UserLocation.fromJson(Map<String, dynamic> json) {
    print(
      "Myidid ${json['id']} user location ${json['latitude']} , ${json['longitude']}",
    );
    return UserLocation(
      id: json['id'] as int?,
      nameAddress: json['name_address'] as String?,
      buildingNumber: json['building_number'] as String?,
      floor: json['floor'] as String?,
      apartment: json['apartment'] as String?,
      addressDescription: json['address_description'] as String?,
      addressTitle: json['address_title'] as String?,
      latitude: json['latitude']?.toString(),
      longitude: json['longitude']?.toString(),
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'name_address': nameAddress,
    'building_number': buildingNumber,
    'floor': floor,
    'apartment': apartment,
    'address_description': addressDescription,
    'address_title': addressTitle,
    'latitude': latitude,
    'longitude': longitude,
    'first_name': firstName,
    'last_name': lastName,
    'phone_number': phoneNumber,
  };
}
