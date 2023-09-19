/// Handle all exception throw by API result
sealed class AppException implements Exception {
  AppException(this.code, this.message);
  final String code;
  final String message;

  @override
  String toString() => message;
}

class EmailAlreadyInUseException extends AppException {
  EmailAlreadyInUseException()
      : super('email-already-in-use', 'Email đã được sử dụng!');
}

class WrongPasswordException extends AppException {
  WrongPasswordException()
      : super('wrong-password', 'Mật khẩu bạn vừa nhập không đúng!');
}

class WrongOTPCodeException extends AppException {
  WrongOTPCodeException()
      : super(
            'wrong-otp-code', 'Mã xác nhận OTP không đúng, vui lòng thử lại!');
}

class WrongPhoneException extends AppException {
  WrongPhoneException() : super('wrong-phone', 'Số điện thoại không đúng!');
}

class UserNotFoundException extends AppException {
  UserNotFoundException() : super('user-not-found', 'User not found');
}

class ServerErrorException extends AppException {
  ServerErrorException() : super('server-error', 'Hệ thống không phản hồi');
}
