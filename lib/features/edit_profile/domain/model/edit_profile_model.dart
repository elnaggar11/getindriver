import 'dart:io';

import 'package:dio/dio.dart';

class EditProfileModel {
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? password;
  File? image;
  String? countryKey;

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = {
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      if (email != null && email!.isNotEmpty) 'email': email,
      if (password != null && password!.isNotEmpty) 'password': password,
      if (image != null) 'image': await MultipartFile.fromFile(image!.path),
      if (countryKey != null) 'country_key': countryKey,
    };

    return data;
  }
}
