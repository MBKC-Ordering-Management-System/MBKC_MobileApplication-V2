import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../configs/routes/app_router.dart';
import '../../../models/response/error_model.dart';
import '../../constants/api_constant.dart';
import '../../enums/enums_export.dart';
import '../widgets/widgets_common_export.dart';

void handleAPIError({
  required Object stateError,
  required BuildContext context,
}) {
  // logger
  final error = (stateError as DioException).response!.data;

  if (error == null) {
    showExceptionAlertDialog(
      context: context,
      title: 'Thông báo',
      exception: 'Máy chủ không phản hồi, vui lòng thử lại.',
    );
    return;
  }

  final errorModel = ErrorModel.fromMap(error);

  switch (errorModel.statusCode.toStatusCodeTypeEnum()) {
    case StatusCodeType.conflict:
    case StatusCodeType.notfound:
    case StatusCodeType.badrequest:
      showExceptionAlertDialog(
        context: context,
        title: 'Thông báo',
        exception: APIConstants
                .errorTrans[errorModel.message.first.descriptionError.first] ??
            'Có lỗi rồi.',
      );
      break;
    case StatusCodeType.exception:
      context.router.push(const ErrorScreenRoute());
      break;
    default:
      showExceptionAlertDialog(
        context: context,
        title: 'Thông báo',
        exception: APIConstants
                .errorTrans[errorModel.message.first.descriptionError.first] ??
            'Có lỗi rồi.',
      );
  }
}
