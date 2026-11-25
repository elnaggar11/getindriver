abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {}

class LoginErrorState extends AuthStates {}

class RegisterLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {}

class RegisterErrorState extends AuthStates {}

class ResendCodeLoadingState extends AuthStates {}

class ResendCodeSuccessState extends AuthStates {}

class ResendCodeErrorState extends AuthStates {}

class ForgetPassLoadingState extends AuthStates {}

class ForgetPassSuccessState extends AuthStates {}

class ForgetPassErrorState extends AuthStates {}

class ActivateCodeLoadingState extends AuthStates {}

class ActivateCodeSuccessState extends AuthStates {
  final String message;
  ActivateCodeSuccessState({required this.message});
}

class ActivateCodeErrorState extends AuthStates {}

class ResetPasswordLoadingState extends AuthStates {}

class ResetPasswordSuccessState extends AuthStates {}

class ResetPasswordErrorState extends AuthStates {}

class VerifyRegisterLoadingState extends AuthStates {}

class VerifyRegisterSuccessState extends AuthStates {}

class VerifyRegisterErrorState extends AuthStates {}

class GetTransportsLoadingState extends AuthStates {}

class GetTransportsSuccessState extends AuthStates {}

class GetTransportsErrorState extends AuthStates {}

class VerifyOtpState extends AuthStates {}
