import '../../../../utils/commons/functions/delay_util.dart';
import '../../../../utils/constants/api_constant.dart';
import '../../../../utils/dummy_data/auth_dummy_data.dart';
import '../../../../utils/exceptions/app_exception.dart';
import '../../../../utils/resources/remote_base_repository.dart';
import '../../domain/models/request/otp_verify_request.dart';
import '../../domain/models/request/sign_in_request.dart';
import '../../domain/models/response/account_reponse.dart';
import '../../domain/repositories/auth_repository.dart';
import '../remote/auth_source.dart';

class AuthRepositoryImpl extends RemoteBaseRepository
    implements AuthRepository {
  final bool addDelay;
  final AuthSource _authSource;
  AuthRepositoryImpl(this._authSource, {this.addDelay = true});

  @override
  Future<AccountReponse> signIn({required SignInRequest request}) async {
    return getDataOf<AccountReponse>(
      request: () => _authSource.signIn(request, APIConstants.contentType),
    );
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
