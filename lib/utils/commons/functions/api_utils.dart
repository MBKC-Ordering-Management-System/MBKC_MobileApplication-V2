import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  VoidCallback? onCallBackGenerateToken,
}) async {
  try {
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
          exception: APIConstants.errorTrans[
                  errorModel.message.first.descriptionError.first] ??
              'Có lỗi rồi.',
        );
        break;

      case StatusCodeType.unauthentication:
        onCallBackGenerateToken != null ? onCallBackGenerateToken() : null;
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
  } catch (e) {
    showExceptionAlertDialog(
      context: context,
      title: 'Thông báo',
      exception: e.toString(),
    );
  }
}

Future<void> reGenerateToken(
  AuthRepository authRepository,
  BuildContext context,
) async {
  if (kDebugMode) {
    print('re-authen');
  }

  final user = await SharedPreferencesUtils.getInstance('user_token');
  if (user != null) {
    final tokenResponse = await authRepository.generateToken(
      request: user.token,
    );

    final userNew = user.copyWith(
      token: tokenResponse,
    );

    await SharedPreferencesUtils.clearInstance('user_token');
    await SharedPreferencesUtils.setInstance(userNew, 'user_token');
  }
}
