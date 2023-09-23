class APIConstants {
  static const String baseUrl = 'https://mbkc.azurewebsites.net';
  static const String contentType = 'application/json';

  // auth
  static const String login = '/api/authentications/login';
  static const String reGenerateToken =
      '/api/authentications/tokens-regeneration';
  static const String resetPassword = '/api/authentications/reset-password';
  static const String verifyEmail = '/api/verifications/email-verification';
  static const String otpVerification = '/api/verifications/otp-verification';
  // statistical
  // order
  // product
  // profile
}
