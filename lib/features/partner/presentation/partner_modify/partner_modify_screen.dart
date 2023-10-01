import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/enums_export.dart';
import '../../../../utils/resources/validations.dart';
import '../../domain/models/partner_model.dart';
import '../../domain/models/request/partner_request.dart';
import 'partner_item_pick.dart';
import 'partner_modify_controller.dart';

@RoutePage()
class PartnerModifyScreen extends HookConsumerWidget with Validations {
  PartnerModifyScreen({
    super.key,
    this.partner,
    required this.type,
  });
  final ModifyType type;
  final PartnerModel? partner;

  // handle submit
  void submit({
    required WidgetRef ref,
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required String username,
    required String password,
    required PartnerType partnerType,
    int? id,
  }) async {
    if (formKey.currentState!.validate()) {
      final partner = PartnerRequest(
        username: username,
        password: password,
        type: partnerType,
      );

      ref
          .read(partnerModifyControllerProvider.notifier)
          .modifyPartner(id, partner, context, type);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final size = MediaQuery.sizeOf(context);
    final partnerType = useState<PartnerType>(
      partner == null ? PartnerType.beamin : partner!.type,
    );
    final username = useTextEditingController(
      text: partner == null ? 'thanhlee2k1' : partner!.username,
    );
    final password = useTextEditingController(
      text: partner == null ? '12345678' : partner!.password,
    );
    final confirmPassword = useTextEditingController(
      text: partner == null ? '12345678' : partner!.password,
    );
    final formKey = useMemoized(GlobalKey<FormState>.new, const []);
    final state = ref.watch(partnerModifyControllerProvider);

    return LoadingOverlay(
      isLoading: state.isLoading,
      child: Scaffold(
        backgroundColor: AssetsConstants.whiteColor,
        appBar: CustomAppBar(
          title: type == ModifyType.create ? 'Tạo Mới' : 'Cập Nhật',
          backButtonColor: AssetsConstants.whiteColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AssetsConstants.defaultPadding - 6.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.01),
                const LabelText(
                  content: 'Chọn đối tác',
                  size: AssetsConstants.defaultFontSize - 10.0,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: size.height * 0.01),
                Container(
                  decoration: BoxDecoration(
                    color: AssetsConstants.whiteColor,
                    border: Border.all(
                      color: AssetsConstants.borderColor,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 2,
                        offset: Offset(0.2, 0.2), // Shadow position
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          partnerType.value = PartnerType.beamin;
                        },
                        child: PartnerItemPick(
                          partnerTypeDynamic: partnerType,
                          partnerTypeStatic: PartnerType.beamin,
                          size: size,
                          isLast: false,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          partnerType.value = PartnerType.shopeefood;
                        },
                        child: PartnerItemPick(
                          partnerTypeDynamic: partnerType,
                          partnerTypeStatic: PartnerType.shopeefood,
                          size: size,
                          isLast: false,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          partnerType.value = PartnerType.grabfood;
                        },
                        child: PartnerItemPick(
                          partnerTypeDynamic: partnerType,
                          partnerTypeStatic: PartnerType.grabfood,
                          size: size,
                          isLast: true,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                const LabelText(
                  content: 'Thông tin tài khoản',
                  size: AssetsConstants.defaultFontSize - 10.0,
                  fontWeight: FontWeight.bold,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.01),
                      TextInput(
                        textController: username,
                        hintText: 'Tài khoản',
                        onValidate: (val) => usernamePartnerMaxErrorText(val),
                        autoFocus: false,
                      ),
                      SizedBox(height: size.height * 0.02),
                      PasswordInput(
                        textEditingController: password,
                        hintText: 'Mật khẩu',
                        onValidate: (val) {
                          var error = 'haha';
                          error = passwordBetweenLengthErrorText(val);
                          return error;
                        },
                        autoFocus: false,
                      ),
                      SizedBox(height: size.height * 0.02),
                      PasswordInput(
                        textEditingController: confirmPassword,
                        hintText: 'Nhập lại mật khẩu',
                        onValidate: (val) {
                          var error = '';
                          error = passwordBetweenLengthErrorText(val);
                          if (password.text.length >= 8 &&
                              confirmPassword.text.length >= 8) {
                            error = passwordEqualErrorText(
                              password.text.trim(),
                              confirmPassword.text.trim(),
                            );
                          }
                          return error;
                        },
                        autoFocus: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: size.height * 0.04),
          padding: const EdgeInsets.only(
            right: AssetsConstants.defaultPadding,
            left: AssetsConstants.defaultPadding,
          ),
          child: ValueListenableBuilder3(
            first: username,
            second: password,
            third: confirmPassword,
            builder: (_, a, b, c, __) => CustomButton(
              content: type == ModifyType.create ? 'Tạo mới' : 'Cập nhật',
              onCallback: () => submit(
                ref: ref,
                context: context,
                formKey: formKey,
                username: username.text.trim(),
                password: password.text.trim(),
                partnerType: partnerType.value,
                id: partner == null ? null : partner!.id,
              ),
              isActive:
                  a.text.isNotEmpty && b.text.isNotEmpty && c.text.isNotEmpty,
              width: size.width * 1,
              height: size.height * 0.05,
              size: AssetsConstants.defaultFontSize - 10.0,
            ),
          ),
        ),
      ),
    );
  }
}
