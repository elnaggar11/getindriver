import 'package:getin_driver/features/auth/domain/model/transport_model/transports_model_list.dart';
import 'package:getin_driver/features/auth/domain/request/register_request.dart';

import '../../../../core/data_source/dio_helper.dart';
import '../../../../core/services/alerts.dart';
import '../request/auth_request.dart';
import 'end_points.dart';

class AuthRepository {
  final DioService dioService;
  AuthRepository(this.dioService);
  Future<TransportsModelList?> getTransports() async {
    final response = await dioService.getData(
      url: AuthEndPoints.getTransports,
      parser: (data) => TransportsModelList.fromJson(data),
    );
    if (response.isError == false) {
      return response.model;
    } else {
      return null;
    }
  }

  loginRequest(AuthRequest user) async {
    final response = await dioService.postData(
      url: AuthEndPoints.login,
      body: user.login(),
      loading: true,
    );
    if (response.isError == false) {
      return response.response?.data['data'];
    } else {
      if (response.response?.data['key'] == 'verify_otp') {
        return true;
      }
      return null;
    }
  }

  registerRequest(DriverRegisterRequest user) async {
    final response = await dioService.postData(
      url: AuthEndPoints.verifyRegister(3),
      body: await user.validBack(3),
      loading: true,
      isForm: true,
      isFile: true,
    );
    if (response.isError == false) {
      return response.response?.data['data'];
    } else {
      return null;
    }
  }

  resendCodeRequest(String phoneNumber, String countryKey) async {
    final response = await dioService.postData(
      url: AuthEndPoints.resendCode,
      body: {
        'phone_number': phoneNumber,
        'country_key': countryKey,
      },
      isForm: true,
    );
    if (response.isError == false) {
      // Alerts.snack(text: response.response?.data['message'], state: 1);
      return response.response?.data;
    } else {
      return null;
    }
  }

  verifyCodeRequest({
    required String email,
    required String countryKey,
    required String code,
  }) async {
    final response = await dioService.postData(
      url: AuthEndPoints.verifyCode,
      body: {'phone_number': email, 'otp': code, 'country_key': countryKey},
      loading: true,
      isForm: true,
    );
    if (response.isError == false) {
      // Alerts.snack(text: response.response?.data['message'], state: 1);
      return response.response?.data;
    } else {
      return null;
    }
  }

  Future<dynamic> verifyRegister(DriverRegisterRequest user, int step) async {
    final response = await dioService.postData(
      url: AuthEndPoints.verifyRegister(step),
      body: await user.validBack(step),
      loading: true,
      isForm: true,
      isFile: true,
    );
    if (response.isError == false) {
      return response.response?.data;
    } else {
      return null;
    }
  }

  forgetPassRequest(AuthRequest request) async {
    final response = await dioService.postData(
      url: AuthEndPoints.forgetPassword,
      body: request.forgetPassword(),
      isForm: true,
      loading: true,
    );
    if (response.isError == false) {
      Alerts.snack(
        text: response.response?.data['message'],
        state: SnackState.success,
      );
      return response.response?.data['data'];
    } else {
      Alerts.snack(
        text: response.response?.data['message'],
        state: SnackState.failed,
      );
      return null;
    }
  }

  resetPassword({
    required String code,
    required String pass,
    required String email,
  }) async {
    final response = await dioService.postData(
      url: AuthEndPoints.resetPassword,
      body: {'code_id': code, 'password': pass, 'email': email},
      isForm: true,
      loading: true,
    );
    if (response.isError == false) {
      Alerts.snack(
        text: response.response?.data['message'],
        state: SnackState.success,
      );
      return true;
    } else {
      Alerts.snack(
        text: response.response?.data['message'],
        state: SnackState.failed,
      );
      return null;
    }
  }
}
