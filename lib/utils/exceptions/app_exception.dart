/// Handle all exception throw by API result
sealed class AppException implements Exception {
  AppException(this.code, this.message);
  final String code;
  final String message;

  @override
  String toString() => message;
}

class EmailNotFoundException extends AppException {
  EmailNotFoundException()
      : super('user-not-found', 'Email không tồn tại trong hệ thống');
}

class UserNotFoundException extends AppException {
  UserNotFoundException()
      : super('user-not-found', 'Thông tin tài khoản không chính xác');
}

class WrongOTPCodeException extends AppException {
  WrongOTPCodeException()
      : super(
            'wrong-otp-code', 'Mã xác nhận OTP không đúng, vui lòng thử lại!');
}

class ServerErrorException extends AppException {
  ServerErrorException() : super('server-error', 'Hệ thống không phản hồi');
}
