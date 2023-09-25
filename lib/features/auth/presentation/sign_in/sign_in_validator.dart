import 'string_validators.dart';

mixin SignInValidators {
  final StringValidator emailRegexValidator = EmailRegexValidator();
  final StringValidator passwordMinLengthValidator =
      MinLengthStringValidator(8);

  bool checkRegexEmail(String email) {
    return emailRegexValidator.isValid(email);
  }

  bool checkLengthPassword(String password) {
    if (passwordMinLengthValidator.isValid(password)) {
      return true;
    }
    return false;
  }

  String emailErrorText(String email) {
    var errorText = '';
    if (!checkRegexEmail(email)) {
      errorText = 'Email có đuôi là @gmail.com';
    }

    return errorText;
  }

  String passwordErrorText(String newPassword) {
    final bool showErrorText = !checkLengthPassword(newPassword);
    const String errorText = 'Mật khẩu có tối thiểu 8 kí tự';
    return showErrorText ? errorText : '';
  }

  String passwordEqualErrorText(String newPassword, String confirmPassword) {
    final bool showErrorText = !(newPassword == confirmPassword);
    const String errorText =
        'Mật khẩu xác nhận không trùng khớp với mật khẩu bạn đã nhập';
    return showErrorText ? errorText : '';
  }
}
