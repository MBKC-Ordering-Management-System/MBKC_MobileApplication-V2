import '../../../../models/user_model.dart';
import '../../../../utils/commons/functions/delay_util.dart';
import '../../../../utils/dummy_data/auth_dummy_data.dart';
import '../../../../utils/exceptions/app_exception.dart';
import '../../../../utils/resources/remote_base_repository.dart';
import '../../domain/models/request/otp_verify_request.dart';
import '../../domain/models/request/sign_in_request.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends RemoteBaseRepository
    implements AuthRepository {
  final bool addDelay;
  AuthRepositoryImpl({this.addDelay = true});

  @override
  Future<UserModel> signIn({required SignInRequest request}) async {
    await delay(addDelay);
    if (request.username != AuthDummyData.emailExist ||
        request.password != AuthDummyData.passwordExis) {
      throw UserNotFoundException();
    }
    return AuthDummyData.userModel;
  }

  @override
  Future<void> getCode({required String email}) async {
    await delay(addDelay);
    return;
  }

  @override
  Future<void> verifyCode({required OTPVerifyRequest request}) async {
    await delay(addDelay);
    if (request.otpcode != AuthDummyData.otpCode) {
      throw WrongOTPCodeException();
    }
    return;
  }

  @override
  Future<void> changePassword({required SignInRequest request}) async {
    await delay(addDelay);
    return;
  }

  @override
  Future<void> checkEmail({required String email}) async {
    await delay(addDelay);
    if (email != AuthDummyData.emailExist) {
      throw EmailNotFoundException();
    }
    return;
  }
}
