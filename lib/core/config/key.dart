class ConstKeys {
  static const liveEnv = true;
  static const baseUrlDev = "https://getin-coffee.subcodeco.com/api/";
  static const baseUrlLive = "https://gettin-backend.subcodeco.com/api/";
  static const moyaser = "";
  static String paymentKeyLive = '';
  static String paymentKeyTest = '';

  static String get paymentKey => liveEnv ? paymentKeyLive : paymentKeyTest;
  static String get baseUrl => liveEnv ? baseUrlLive : baseUrlDev;

  static get baseNoApi {
    return baseUrl.replaceAll("/api", "");
  }
}
