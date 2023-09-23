import '../../exceptions/app_exception.dart';

String getErrorDescription(AppException error) {
  switch (error) {
    case UserNotFoundException():
      return 'haha';
    default:
      return '';
  }
}
