import '../../../../models/refresh_token_model.dart';
import '../../../../models/response/success_model.dart';
import '../../../../utils/constants/api_constant.dart';
import '../../../../utils/resources/remote_base_repository.dart';
import '../../domain/models/request/change_password_request.dart';
import '../../domain/models/request/email_verify_request.dart';
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
  Future<AccountReponse> signIn({required SignInRequest request}) {
    return getDataOf(
      request: () => _authSource.signIn(request, APIConstants.contentType),
    );
  }

  @override
  Future<TokenModel> generateToken({required TokenModel request}) {
    return getDataOf(
      request: () =>
          _authSource.generateToken(request, APIConstants.contentType),
    );
  }

  @override
  Future<SuccessModel> changePassword({
    required ChangePasswordRequest request,
  }) {
    return getDataOf(
      request: () =>
          _authSource.changePassword(request, APIConstants.contentType),
    );
  }

  @override
  Future<SuccessModel> verifyEmail({required EmailVerifyRequest request}) {
    return getDataOf(
      request: () => _authSource.verifyEmail(request, APIConstants.contentType),
    );
  }

  @override
  Future<SuccessModel> verifyOTPCode({required OTPVerifyRequest request}) {
    return getDataOf(
      request: () =>
          _authSource.verifyOTPCode(request, APIConstants.contentType),
    );
  }
}
