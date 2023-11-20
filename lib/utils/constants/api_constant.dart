class APIConstants {
  static const baseUrl = 'https://mbkc.azurewebsites.net/api/v1';
  static const contentType = 'application/json';
  static const contentHeader = 'Content-Type';
  static const authHeader = 'Authorization';
  static const prefixToken = 'bearer ';

  // auth
  static const login = '/authentications/login';
  static const reGenerateToken = '/authentications/regeneration-tokens';
  static const resetPassword = '/authentications/password-resetation';
  static const verifyEmail = '/verifications/email-verification';
  static const otpVerification = '/verifications/otp-verification';
  static const changeFirstTime = '/accounts';

  // notification
  static const userToken = '/user-devices';

  // dashboard
  static const dashboard = '/dashboards/store';

  // order
  static const order = '/orders';

  // category
  static const product = '/products';

  // product
  static const category = '/categories';

  // profile
  static const getProfile = '/stores/profile';

  // money exchange
  static const moneyExchange = '/money-exchanges';

  // wallet
  static const wallet =
      '/wallets/transaction-money-exchange-shipper-payment-information';

  // error
  static const Map<String, String> errorTrans = {
    'Email does not exist in the system.':
        'Email không tồn tại trong hệ thống.',
    'Email or Password is invalid.': 'Email hoặc mật khẩu không hợp lệ.',
    'Your OTP code does not match the previously sent OTP code.':
        'Mã OTP bạn nhập không đúng.',
    'Email is invalid Email format.': 'Email sai định dạng.',
    'OTP code has expired.': 'Mã OTP đã hết hạn',
    'Email has not been previously authenticated.': 'Email chưa được xác thực',
    'Email is not yet authenticated with the previously sent OTP code.':
        'Email chưa được xác thực bằng mã OTP',
    'You are not allowed to access this function!':
        'Bạn không có quyền truy cập hệ thống',
  };
}
