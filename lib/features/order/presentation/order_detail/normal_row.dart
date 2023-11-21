import 'package:flutter/material.dart';
import '../../../../utils/commons/functions/functions_common_export.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';

class NormalRow extends StatelessWidget {
  const NormalRow({super.key, required this.content});
  final List<Map<String, dynamic>> content;

  @override
  Widget build(BuildContext context) {
    // init
    final size = MediaQuery.sizeOf(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AssetsConstants.defaultPadding - 15.0,
        horizontal: AssetsConstants.defaultPadding - 10.0,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AssetsConstants.borderColor),
        ),
      ),
      child: Column(
        children: [
          ...content.map(
            (e) => Container(
              margin: const EdgeInsets.symmetric(
                vertical: AssetsConstants.defaultMargin - 5.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //*** LABEL ***
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: LabelText(
                        content: e.entries.first.key,
                        size: AssetsConstants.defaultFontSize - 13.0,
                        fontWeight: (e.entries.first.key == 'Tổng cộng:' ||
                                e.entries.first.key == 'Trạng thái hệ thống:' ||
                                e.entries.first.key == 'Trạng thái đối tác:' ||
                                e.entries.first.key == 'Số tiền:' ||
                                e.entries.first.key == 'Tiền thu hộ:' ||
                                e.entries.first.key ==
                                    'Thanh toán của giao hàng')
                            ? FontWeight.bold
                            : FontWeight.w600,
                        color: getColorByKey(e.entries.first.key),
                      ),
                    ),
                  ),

                  //*** VALUE ***
                  (e.entries.first.key == 'Trạng thái hệ thống:' ||
                          e.entries.first.key == 'Trạng thái đối tác:')
                      ? Container(
                          height: size.height * 0.04,
                          width: size.width * 0.35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: e.entries.first.key == 'Trạng thái hệ thống:'
                                ? getBackgroundColorSystemStatus(
                                    (e.entries.first.value as String)
                                        .toOrderSystemTypeEnum(),
                                  )
                                : getBackgroundColorPartnerStatus(
                                    (e.entries.first.value as String)
                                        .toOrderPartnerTypeEnum(),
                                  ),
                          ),
                          child: Center(
                            child: LabelText(
                              content:
                                  e.entries.first.key == 'Trạng thái hệ thống:'
                                      ? getTitleSystemStatus(
                                          (e.entries.first.value as String)
                                              .toOrderSystemTypeEnum(),
                                        )
                                      : getTitlePartnerStatus(
                                          (e.entries.first.value as String)
                                              .toOrderPartnerTypeEnum(),
                                        ),
                              size: AssetsConstants.defaultFontSize - 14.0,
                              fontWeight: FontWeight.w600,
                              color:
                                  e.entries.first.key == 'Trạng thái hệ thống:'
                                      ? getContentColorSystemStatus(
                                          (e.entries.first.value as String)
                                              .toOrderSystemTypeEnum(),
                                        )
                                      : getContentColorPartnerStatus(
                                          (e.entries.first.value as String)
                                              .toOrderPartnerTypeEnum(),
                                        ),
                            ),
                          ),
                        )
                      : e.entries.first.key == 'Thanh toán của giao hàng'
                          ? Container()
                          : e.entries.first.key == 'Hình ảnh:'
                              ? Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      await showAlertDialogImage(
                                          context: context,
                                          imageUrl: e.entries.first.value);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: FadeInImage(
                                        placeholder: const AssetImage(
                                            AssetsConstants.welcomeImage),
                                        image:
                                            NetworkImage(e.entries.first.value),
                                      ),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: LabelText(
                                      content: getCustomContent(e),
                                      size: AssetsConstants.defaultFontSize -
                                          13.0,
                                      fontWeight: (e.entries.first.key ==
                                                  'Tổng cộng:' ||
                                              e.entries.first.key == 'Số tiền:')
                                          ? FontWeight.bold
                                          : FontWeight.w600,
                                      maxLine: 10,
                                    ),
                                  ),
                                ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
