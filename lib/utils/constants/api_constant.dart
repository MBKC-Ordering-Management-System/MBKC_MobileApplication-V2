class APIConstants {
  static const baseUrl = 'https://mbkc.azurewebsites.net';
  static const contentType = 'application/json';

  // auth
  static const login = '/api/authentications/login';
  static const reGenerateToken = '/api/authentications/tokens-regeneration';
  static const resetPassword = '/api/authentications/reset-password';
  static const verifyEmail = '/api/verifications/email-verification';
  static const otpVerification = '/api/verifications/otp-verification';
  // statistical
  // order
  // product
  // profile
  // error
  static const emailpassinvalid = {
    'Email or Password is invalid.',
    'Email hoặc mật khẩu không hợp lệ'
  };

  static const emailnotFound = 'Email không tồn tại trong hệ thống';
}
