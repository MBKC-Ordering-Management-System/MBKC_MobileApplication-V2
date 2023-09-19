import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../models/user_model.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../models/request/sign_in_request.dart';

part 'auth_repository.g.dart';

abstract class AuthRepository {
  Future<UserModel> signIn({required SignInRequest request});
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl();
}
