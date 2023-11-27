import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../models/token_model.dart';
import '../../../../models/response/success_model.dart';
import '../../data/remote/auth_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../models/request/change_first_time_request.dart';
import '../models/request/change_password_request.dart';
import '../models/request/email_verify_request.dart';
import '../models/request/otp_verify_request.dart';
import '../models/request/register_token_request.dart';
import '../models/request/sign_in_request.dart';
import '../models/response/account_reponse.dart';

part 'auth_repository.g.dart';

abstract class AuthRepository {
  Future<AccountReponse> signIn({required SignInRequest request});

  Future<TokenModel> generateToken({required TokenModel request});

  Future<SuccessModel> changePassword({required ChangePasswordRequest request});

  Future<SuccessModel> verifyEmail({required EmailVerifyRequest request});

  Future<SuccessModel> verifyOTPCode({required OTPVerifyRequest request});

  Future<SuccessModel> changeFirstTime({
    required ChangeFirstTimeRequest request,
    required int id,
    required String accessToken,
  });

  Future<void> signOut();

  Future<SuccessModel> registerToken({
    required RegisterTokenRequest request,
    required String accessToken,
  });

  Future<SuccessModel> deleteToken({
    required int id,
  });
}

@Riverpod(keepAlive: false)
AuthRepository authRepository(AuthRepositoryRef ref) {
  final authSource = ref.read(authSourceProvider);
  return AuthRepositoryImpl(authSource);
}
