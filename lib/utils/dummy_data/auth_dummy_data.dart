import '../../models/user_model.dart';

class AuthDummyData {
  static const userNameExist = 'test@gmail.com';
  static const passwordExis = '12345678';
  static const otpCode = '000000';
  static final userModel = UserModel(
    id: 1,
    username: 'test@gmail.com',
    name: 'Passio hohohaha',
    role: 'store',
    accessToken: 'hihi',
    refreshToken: 'haha',
  );
}
