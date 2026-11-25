/// For Login / OTP / Password flows
class AuthRequest {
  String? phone;
  String? code;
  String countryKey = '+90';
  String? email;
  String? password;
  String? passwordConfirmation;
  String? fcmToken;
  String? agree;
  String? otp;
  String? newPassword;
  String? newPasswordConfirmation;

  AuthRequest({
    this.phone,
    this.code,
    this.countryKey = '+90',
    this.email,
    this.password,
    this.passwordConfirmation,
    this.fcmToken,
    this.agree,
    this.otp,
    this.newPassword,
    this.newPasswordConfirmation,
  });

  Map<String, dynamic> login() => {
    'phone_number': "${code ?? ''}${phone ?? ''}",
    'password': password,
    'country_key': countryKey,
    'fcm_token': fcmToken,
  };

  Map<String, dynamic> verifyOtp() => {
    'phone_number': "${code ?? ''}${phone ?? ''}",
    'otp': otp,
    'country_key': countryKey,
  };

  Map<String, dynamic> resendOtp() => {
    'phone_number': "${code ?? ''}${phone ?? ''}",
  };

  Map<String, dynamic> forgetPassword() => {
    'phone_number': "${code ?? ''}${phone ?? ''}",
    'country_key': countryKey,
  };

  Map<String, dynamic> resetPassword() => {
    'phone_number': "${code ?? ''}${phone ?? ''}",
    'otp': otp,
    'new_password': newPassword,
    'new_password_confirmation': newPasswordConfirmation,
  };
}
