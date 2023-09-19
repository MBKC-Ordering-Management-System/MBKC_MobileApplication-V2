import 'package:flutter/material.dart';
import '../../constants/asset_constant.dart';
import 'label_text.dart';

const kDialogDefaultKey = Key('dialog-default-key');

/// Generic function to show a platform-aware Material or Cupertino dialog
Future<bool?> showAlertDialog({
  required BuildContext context,
  required String title,
  String? content,
  String? cancelActionText,
  String defaultActionText = 'OK',
}) async {
  final size = MediaQuery.sizeOf(context);
  return showDialog(
    context: context,
    // * Only make the dialog dismissible if there is a cancel button
    barrierDismissible: cancelActionText != null,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          LabelText(
            content: title,
            size: AssetsConstants.defaultFontSize,
            color: AssetsConstants.whiteColor,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(width: size.width * 0.02),
          const Icon(Icons.error_outline, size: 30)
        ],
      ),
      backgroundColor: AssetsConstants.mainColor,
      content: SizedBox(
        height: size.height * 0.1,
        width: size.width * 1,
        child: content != null
            ? LabelText(
                content: content,
                size: AssetsConstants.defaultFontSize - 4.0,
                color: AssetsConstants.whiteColor,
              )
            : null,
      ),
      actions: <Widget>[
        if (cancelActionText != null)
          TextButton(
            child: LabelText(
              content: cancelActionText,
              size: AssetsConstants.defaultFontSize,
            ),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              width: 2,
              color: AssetsConstants.whiteColor,
            ),
          ),
          key: kDialogDefaultKey,
          child: LabelText(
            content: defaultActionText,
            size: AssetsConstants.defaultFontSize - 4.0,
            color: AssetsConstants.whiteColor,
            fontWeight: FontWeight.bold,
          ),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );
}

/// Generic function to show a platform-aware Material or Cupertino error dialog
Future<void> showExceptionAlertDialog({
  required BuildContext context,
  required String title,
  required dynamic exception,
}) =>
    showAlertDialog(
      context: context,
      title: title,
      content: exception.toString(),
    );

/// show not implement from aleart dialog
Future<void> showNotImplementedAlertDialog({required BuildContext context}) =>
    showAlertDialog(
      context: context,
      title: 'Not implemented',
    );
