import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/remote/auth_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../models/request/otp_verify_request.dart';
import '../models/request/sign_in_request.dart';
import '../models/response/account_reponse.dart';

part 'auth_repository.g.dart';

abstract class AuthRepository {
  Future<AccountReponse> signIn({required SignInRequest request});

  Future<void> checkEmail({required String email});

  Future<void> getCode({required String email});

  Future<void> verifyCode({required OTPVerifyRequest request});

  Future<void> changePassword({required SignInRequest request});
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  final authSource = ref.read(authSourceProvider);
  return AuthRepositoryImpl(authSource);
}
