class AuthEndPoints {
  static const String login = 'driver/auth/login';
  static const String register = 'driver/auth/register';
  static const String verifyCode = 'driver/auth/verify-otp';
  static const String logout = 'driver/auth/logout';

  static const String resendCode = 'driver/auth/resend-otp';
  static const String forgetPassword = 'driver/auth/forget-password';
  static const String resetPassword = 'driver/auth/reset-password';
  static const String getTransports = 'driver/auth/vehicle-type';
  static String verifyRegister(int step) =>
      'driver/auth/register/step${step + 1}';
}
