import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

class DriverRegisterRequest {
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? password;
  String? confirmPassword;
  String? email;
  String? idNumber;
  String? dateOfBirth;
  String? nationality;
  String countryKey = '+90';

  String? typeOfVehicle;
  String? vehicleModel;
  String? yearOfManufacture;
  String? licensePlateNumber;

  String? licenseIssueDate;
  String? licenseExpiryDate;

  bool? previousExperience;
  String? experience;
  String? city;
  String? districtArea;
  bool? haveGps;
  String? notes;

  // File paths (to upload via multipart)
  File? profileImage;
  File? vehicleRegistrationDocument;
  File? vehicleInsuranceDocument;
  File? drivingLicensePhoto;

  DriverRegisterRequest({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.countryKey = '+90',
    this.idNumber,
    this.dateOfBirth,
    this.nationality,
    this.typeOfVehicle,
    this.vehicleModel,
    this.yearOfManufacture,
    this.licensePlateNumber,
    this.licenseIssueDate,
    this.licenseExpiryDate,
    this.previousExperience,
    this.experience,
    this.city,
    this.districtArea,
    this.haveGps,
    this.notes,
    this.profileImage,
    this.vehicleRegistrationDocument,
    this.vehicleInsuranceDocument,
    this.drivingLicensePhoto,
  });

  /// For sending text fields (files handled separately in Dio / http Multipart)
  Future<Map<String, dynamic>> toJson() async {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "phone_number": phoneNumber,
      "country_key": countryKey,
      "email": email,
      "id_number": idNumber,
      "date_of_birth": (dateOfBirth?.isEmpty ?? true)
          ? "2025-08-27"
          : dateOfBirth!,
      "nationality": nationality,
      "type_of_vehicle": typeOfVehicle,
      "vehicle_model": vehicleModel,
      "year_of_manufacture": yearOfManufacture,
      "license_plate_number": licensePlateNumber,
      "license_issue_date": licenseIssueDate,
      "license_expiry_date": licenseExpiryDate,
      "previous_experience": previousExperience ?? false
          ? 1
          : 0, // previousExperience,
      "experience": experience?.isEmpty ?? true ? "sss" : experience!,
      "city": city,
      "district_area": districtArea,
      "have_gps": haveGps ?? false ? 1 : 0, //haveGps,
      "notes": notes,
      "profile_image": profileImage != null
          ? await MultipartFile.fromFile(profileImage!.path)
          : null,
      "vehicle_registration_document": vehicleRegistrationDocument != null
          ? await MultipartFile.fromFile(vehicleRegistrationDocument!.path)
          : null,
      "vehicle_insurance_document": vehicleInsuranceDocument != null
          ? await MultipartFile.fromFile(vehicleInsuranceDocument!.path)
          : null,
      "driving_license_photo": drivingLicensePhoto != null
          ? await MultipartFile.fromFile(drivingLicensePhoto!.path)
          : null,
      "password": password,

      "password_confirmation": confirmPassword,
    };
  }

  String? validate(int step) {
    log(profileImage?.path ?? "ddd", name: "profileImage");
    switch (step) {
      case 0:
        return validateStep0();
      case 1:
        return validateStep1();
      case 2:
        return validateStep2();
      case 3:
        return validateStep3();
      default:
        return null;
    }
  }

  String? validateStep0() {
    if (profileImage == null) {
      return "Please upload a profile picture";
    }
    if (password == null) {
      return "Please scroll up and enter a password";
    }
    if (confirmPassword == null) {
      return "Please scroll down and enter a confirm password";
    }

    return null;
  }

  String? validateStep1() {
    if (vehicleRegistrationDocument == null) {
      return "Vehicle Registration Document is required";
    }
    if (vehicleInsuranceDocument == null) {
      return "Vehicle Insurance Document is required";
    }

    return null;
  }

  String? validateStep2() {
    if (drivingLicensePhoto == null) {
      return "Driving License Photo is required";
    }
    if (licenseIssueDate == null) {
      return "License Issue Date is required";
    }
    if (licenseExpiryDate == null) {
      return "License Expiry Date is required";
    }
    return null;
  }

  String? validateStep3() {
    if (vehicleInsuranceDocument == null) {
      return "Vehicle Insurance Document is required";
    }

    return null;
  }

  Future<Map<String, dynamic>>? validBack(int step) async {
    log(profileImage?.path ?? "ddd", name: "profileImage");
    switch (step) {
      case 0:
        return await validateStepBack0();
      case 1:
        return await validateStepBack1();
      case 2:
        return await validateStepBack2();
      case 3:
        return await validateStepBack3();
      default:
        return await validateStepBack3();
    }
  }

  Future<Map<String, dynamic>> validateStepBack0() async {
    return {
      "profile_image": await MultipartFile.fromFile(profileImage!.path),
      "first_name": firstName,
      "last_name": lastName,
      "phone_number": phoneNumber,
      "country_key": countryKey,
      "email": email,
      "id_number": idNumber,
      "date_of_birth": (dateOfBirth?.isEmpty ?? true)
          ? "2025-08-27"
          : dateOfBirth!,

      "password": password,
      "password_confirmation": confirmPassword,
      "nationality": nationality,
    };
  }

  Future<Map<String, dynamic>> validateStepBack1() async {
    return {
      "email": email,
      "vehicle_registration_document": await MultipartFile.fromFile(
        vehicleRegistrationDocument!.path,
      ),
      "vehicle_insurance_document": await MultipartFile.fromFile(
        vehicleInsuranceDocument!.path,
      ),
      "vehicle_model": vehicleModel,
      "vehicle_type_id": typeOfVehicle,
      "year_of_manufacture": yearOfManufacture,
      "license_plate_number": licensePlateNumber,
    };
  }

  Future<Map<String, dynamic>> validateStepBack2() async {
    return {
      "email": email,

      "driving_license_photo": await MultipartFile.fromFile(
        drivingLicensePhoto!.path,
      ),
      "license_issue_date": licenseIssueDate,
      "license_expiry_date": licenseExpiryDate,
      "previous_experience": (previousExperience ?? false) ? 1 : 0,
      "experience": experience,
    };
  }

  Future<Map<String, dynamic>> validateStepBack3() async {
    return {
      "email": email,
      "city": city,
      "district_area": districtArea,
      "have_gps": haveGps ?? false ? 1 : 0,
      "notes": notes,
    };
  }
}
