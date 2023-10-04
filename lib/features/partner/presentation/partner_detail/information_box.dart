import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../../utils/commons/functions/color_utils.dart';
import '../../../../utils/commons/widgets/label_text.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';

class InformationBox extends HookWidget {
  const InformationBox({
    super.key,
    required this.isPassword,
    required this.type,
    required this.content,
  });
  final bool isPassword;
  final PartnerType type;
  final String content;

  @override
  Widget build(BuildContext context) {
    // init
    final size = MediaQuery.sizeOf(context);
    final hidePassword = useState(true);

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: size.height * 0.08,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AssetsConstants.defaultPadding - 10.0,
        ),
        width: size.width * 1,
        decoration: BoxDecoration(
          color: getColorPartner(type),
          borderRadius: BorderRadius.circular(AssetsConstants.defaultBorder),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LabelText(
              content:
                  (isPassword && hidePassword.value) ? '********' : content,
              size: AssetsConstants.defaultFontSize - 10.0,
              color: AssetsConstants.whiteColor,
              fontWeight: FontWeight.w600,
            ),
            if (isPassword)
              IconButton(
                onPressed: () {
                  hidePassword.value = !hidePassword.value;
                },
                icon: Icon(
                  hidePassword.value ? Icons.visibility : Icons.visibility_off,
                  color: AssetsConstants.whiteColor,
                  size: AssetsConstants.defaultFontSize - 6.0,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
