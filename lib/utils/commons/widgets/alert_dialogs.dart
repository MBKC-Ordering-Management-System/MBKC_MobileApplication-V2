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
  String defaultActionText = 'Đồng ý',
}) async {
  final size = MediaQuery.sizeOf(context);
  return showDialog(
    context: context,
    // * Only make the dialog dismissible if there is a cancel button
    barrierDismissible: cancelActionText != null,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(AssetsConstants.defaultBorder - 5.0),
      ),
      title: Row(
        children: [
          LabelText(
            content: title,
            size: AssetsConstants.defaultFontSize - 10.0,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(width: size.width * 0.02),
          const Icon(
            Icons.error_outline,
            size: AssetsConstants.defaultFontSize - 10.0,
            color: AssetsConstants.blackColor,
          )
        ],
      ),
      backgroundColor: AssetsConstants.whiteColor,
      shadowColor: AssetsConstants.primaryLight,
      surfaceTintColor: AssetsConstants.whiteColor,
      content: content != null
          ? LabelText(
              content: content,
              maxLine: 3,
              size: AssetsConstants.defaultFontSize - 12.0,
            )
          : null,
      actions: <Widget>[
        Row(
          mainAxisAlignment: cancelActionText == null
              ? MainAxisAlignment.end
              : MainAxisAlignment.spaceBetween,
          children: [
            if (cancelActionText != null)
              SizedBox(
                width: size.width * 0.3,
                child: OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      const BorderSide(),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AssetsConstants.defaultBorder - 5.0,
                        ),
                      ),
                    ),
                  ),
                  child: LabelText(
                    content: cancelActionText,
                    size: AssetsConstants.defaultFontSize - 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
              ),
            SizedBox(
              width: size.width * 0.3,
              child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AssetsConstants.primaryDark),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AssetsConstants.defaultBorder - 5.0,
                      ),
                    ),
                  ),
                ),
                key: kDialogDefaultKey,
                child: LabelText(
                  content: defaultActionText,
                  size: AssetsConstants.defaultFontSize - 15.0,
                  color: AssetsConstants.whiteColor,
                  fontWeight: FontWeight.bold,
                ),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ),
          ],
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
