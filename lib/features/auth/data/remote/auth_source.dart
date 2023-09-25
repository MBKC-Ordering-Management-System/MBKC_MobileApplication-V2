import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../models/token_model.dart';
import '../../../../models/response/success_model.dart';
import '../../../../utils/constants/api_constant.dart';
import '../../../../utils/providers/common_provider.dart';
import '../../domain/models/request/change_password_request.dart';
import '../../domain/models/request/email_verify_request.dart';
import '../../domain/models/request/otp_verify_request.dart';
import '../../domain/models/request/sign_in_request.dart';
import '../../domain/models/response/account_reponse.dart';

part 'auth_source.g.dart';

@RestApi(baseUrl: APIConstants.baseUrl, parser: Parser.MapSerializable)
abstract class AuthSource {
  factory AuthSource(Dio dio, {String baseUrl}) = _AuthSource;

  @POST(APIConstants.login)
  Future<HttpResponse<AccountReponse>> signIn(
    @Body() SignInRequest request,
    @Header("Content-Type") String contentType,
  );

  @POST(APIConstants.reGenerateToken)
  Future<HttpResponse<TokenModel>> generateToken(
    @Body() TokenModel request,
    @Header("Content-Type") String contentType,
  );

  @PUT(APIConstants.resetPassword)
  Future<HttpResponse<SuccessModel>> changePassword(
    @Body() ChangePasswordRequest request,
    @Header("Content-Type") String contentType,
  );

  @POST(APIConstants.verifyEmail)
  Future<HttpResponse<SuccessModel>> verifyEmail(
    @Body() EmailVerifyRequest request,
    @Header("Content-Type") String contentType,
  );

  @POST(APIConstants.otpVerification)
  Future<HttpResponse<SuccessModel>> verifyOTPCode(
    @Body() OTPVerifyRequest request,
    @Header("Content-Type") String contentType,
  );
}

@riverpod
AuthSource authSource(AuthSourceRef ref) {
  final dio = ref.read(dioProvider);
  return AuthSource(dio);
}
