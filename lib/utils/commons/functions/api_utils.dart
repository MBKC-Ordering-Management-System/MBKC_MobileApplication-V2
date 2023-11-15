import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../models/token_model.dart';
import '../../../models/user_model.dart';
import 'functions_common_export.dart';
import '../../../features/auth/domain/repositories/auth_repository.dart';
import '../../../models/response/error_model.dart';
import '../../constants/api_constant.dart';
import '../../enums/enums_export.dart';
import '../widgets/widgets_common_export.dart';

Future<void> handleAPIError({
  required Object stateError,
  required BuildContext context,
  required int statusCode,
  Future<void>? onCallBackGenerateToken,
}) async {
  final error = (stateError as DioException).response!.data;
  if (error == null) {
    showExceptionAlertDialog(
      context: context,
      title: 'Thông báo',
      exception: 'Có lỗi rồi.',
    );
    return;
  }
  final errorModel = ErrorModel.fromMap(error);
  switch (statusCode.toStatusCodeTypeEnum()) {
    case StatusCodeType.conflict:
    case StatusCodeType.notfound:
    case StatusCodeType.badrequest:
    case StatusCodeType.forbidden:
      showExceptionAlertDialog(
        context: context,
        title: 'Thông báo',
        exception: APIConstants
                .errorTrans[errorModel.message.first.descriptionError.first] ??
            'Có lỗi rồi.',
      );
      break;

    case StatusCodeType.unauthentication:
      await onCallBackGenerateToken;
      break;

    case StatusCodeType.exception:
      showExceptionAlertDialog(
        context: context,
        title: 'Thông báo',
        exception: 'Máy chủ không phản hồi, vui lòng thử lại.',
      );
      break;

    default:
      showExceptionAlertDialog(
        context: context,
        title: 'Thông báo',
        exception: APIConstants
                .errorTrans[error.message.first.descriptionError.first] ??
            'Có lỗi rồi.',
      );
  }
}

Future<void> reGenerateToken(
  AuthRepository authRepository,
  BuildContext context,
) async {
  // ignore: avoid_print
  print('re-authen');
  final user = await SharedPreferencesUtils.getInstance('user_token');
  if (user != null) {
    final tokenResponse = await authRepository.generateToken(
      request: user.token,
    );

    final userNew = UserModel(
      accountId: user.accountId,
      storeId: user.storeId,
      email: user.email,
      token: TokenModel(
        accessToken: tokenResponse.accessToken,
        refreshToken: tokenResponse.refreshToken,
      ),
    );

    await SharedPreferencesUtils.clearInstance('user_token');
    await SharedPreferencesUtils.setInstance(userNew, 'user_token');
  }
}
