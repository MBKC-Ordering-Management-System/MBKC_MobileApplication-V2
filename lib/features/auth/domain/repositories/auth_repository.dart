import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../models/token_model.dart';
import '../../../../models/response/success_model.dart';
import '../../data/remote/auth_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../models/request/change_password_request.dart';
import '../models/request/email_verify_request.dart';
import '../models/request/otp_verify_request.dart';
import '../models/request/sign_in_request.dart';
import '../models/response/account_reponse.dart';

part 'auth_repository.g.dart';

abstract class AuthRepository {
  Future<AccountReponse> signIn({required SignInRequest request});

  Future<TokenModel> generateToken({required TokenModel request});

  Future<SuccessModel> changePassword({required ChangePasswordRequest request});

  Future<SuccessModel> verifyEmail({required EmailVerifyRequest request});

  Future<SuccessModel> verifyOTPCode({required OTPVerifyRequest request});

  Future<void> signOut();
}

@Riverpod(keepAlive: false)
AuthRepository authRepository(AuthRepositoryRef ref) {
  final authSource = ref.read(authSourceProvider);
  return AuthRepositoryImpl(authSource);
}
