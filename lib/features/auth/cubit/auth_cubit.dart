import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getin_driver/features/auth/domain/model/transport_model/datum.dart';
import 'package:getin_driver/features/auth/domain/request/register_request.dart';

import '../../../core/data_source/dio_helper.dart';
import '../../../core/utils/Locator.dart';
import '../../../core/utils/utils.dart';
import '../../auth/domain/request/auth_request.dart';
import '../domain/repository/auth_repository.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  AuthRepository authRepository = AuthRepository(locator<DioService>());
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<FormState> formkey1 = GlobalKey<FormState>();
  GlobalKey<FormState> formkey2 = GlobalKey<FormState>();
  GlobalKey<FormState> formkey3 = GlobalKey<FormState>();
  String countryKey = '+90';
  DriverRegisterRequest registerRequestModel = DriverRegisterRequest();
  bool validate(int step) {
    switch (step) {
      case 0:
        return formkey.currentState!.validate();
      case 1:
        return formkey1.currentState!.validate();
      case 2:
        return formkey2.currentState!.validate();
      case 3:
        return formkey3.currentState!.validate();
      default:
        return false;
    }
  }

  Future<bool?> login({required AuthRequest loginRequestModel}) async {
    emit(LoginLoadingState());
    final response = await authRepository.loginRequest(loginRequestModel);

    if (response != null) {
      if (response is bool) {
        emit(VerifyOtpState());
        return false;
      } else {
        await Utils.saveUserInHive(response);
        emit(LoginSuccessState());
        return true;
      }
    } else {
      emit(LoginErrorState());
      return null;
    }
  }

  signUp({required DriverRegisterRequest registerRequestModel}) async {
    emit(RegisterLoadingState());
    final response = await authRepository.registerRequest(registerRequestModel);
    if (response != null) {
      emit(RegisterSuccessState());
      return true;
    } else {
      emit(RegisterErrorState());
      return false;
    }
  }

  verifyRegister({
    required DriverRegisterRequest registerRequestModel,
    required int step,
  }) async {
    emit(VerifyRegisterLoadingState());
    final response = await authRepository.verifyRegister(
      registerRequestModel,
      step,
    );
    if (response != null) {
      emit(VerifyRegisterSuccessState());
      return true;
    } else {
      emit(VerifyRegisterErrorState());
      return false;
    }
  }

  resendCode(String email, String countryKey) async {
    emit(ResendCodeLoadingState());
    final response = await authRepository.resendCodeRequest(email,countryKey);

    if (response != null) {
      emit(ResendCodeSuccessState());

      return true;
    } else {
      emit(ResendCodeErrorState());
      return null;
    }
  }

  forgetPass(AuthRequest request) async {
    emit(ForgetPassLoadingState());
    var res = await authRepository.forgetPassRequest(request);
    if (res != null) {
      emit(ForgetPassSuccessState());
      return true;
    } else {
      emit(ForgetPassErrorState());
      return null;
    }
  }

  String codeId = "";
  Future<bool?> verifyCode({
    required String email,
    required String countryKey,

    required String code,
  }) async {
    emit(ActivateCodeLoadingState());
    final response = await authRepository.verifyCodeRequest(
      email: email,
      countryKey: countryKey,
      code: code,
    );
    if (response != null) {
      // codeId = response['code_id'].toString();
      emit(ActivateCodeSuccessState(message: response['message']));
      return true;
    } else {
      emit(ActivateCodeErrorState());
      return null;
    }
  }

  resetPassword({
    required String code,
    required String pass,
    required String email,
  }) async {
    emit(ResetPasswordLoadingState());
    var res = await authRepository.resetPassword(
      code: code,
      pass: pass,
      email: email,
    );
    if (res != null) {
      emit(ResetPasswordSuccessState());
      return res;
    } else {
      emit(ResetPasswordErrorState());
      return null;
    }
  }

  Future<List<TransportModel>> getTransports() async {
    emit(GetTransportsLoadingState());
    final response = await authRepository.getTransports();
    if (response != null) {
      emit(GetTransportsSuccessState());
      return response.transports ?? [];
    } else {
      emit(GetTransportsErrorState());
      return [];
    }
  }
}
