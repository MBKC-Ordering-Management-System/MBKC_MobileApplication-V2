class APIConstants {
  static const baseUrl = 'https://mbkc.azurewebsites.net/api/v1';
  static const contentType = 'application/json';

  // auth
  static const login = '/authentications/login';
  static const reGenerateToken = '/authentications/regeneration-tokens';
  static const resetPassword = '/authentications/password-resetation';
  static const verifyEmail = '/verifications/email-verification';
  static const otpVerification = '/verifications/otp-verification';
  // statistical
  // order
  // product
  // profile
  // error
  static const Map<String, String> errorTrans = {
    'Email does not exist in the system.':
        'Email không tồn tại trong hệ thống.',
    'Email or Password is invalid.': 'Email hoặc mật khẩu không hợp lệ.',
    'Your OTP code does not match with the previously sent OTP code.':
        'Mã OTP bạn nhập không đúng.',
    'Email is invalid Email format.': 'Email sai định dạng.',
    'OTP code has expired.': 'Mã OTP đã hết hạn',
    'Email has not been previously authenticated.': 'Email chưa được xác thực',
    'Email is not yet authenticated with the previously sent OTP code.':
        'Email chưa được xác thực bằng mã OTP',
  };
}
