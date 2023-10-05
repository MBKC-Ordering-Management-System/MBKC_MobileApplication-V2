import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../configs/routes/app_router.dart';
import '../../../../models/request/paging_model.dart';
import '../../../../utils/commons/widgets/widgets_common_export.dart';
import '../../../../utils/constants/asset_constant.dart';
import '../../../../utils/enums/modify_type.dart';
import '../../domain/models/partner_model.dart';
import 'partner_controller.dart';
import 'partner_item.dart';

@RoutePage()
class PartnerScreen extends HookConsumerWidget {
  const PartnerScreen({super.key});

  // fetch data
  Future<void> fetchData({
    required WidgetRef ref,
    required BuildContext context,
    required ValueNotifier<List<PartnerModel>> partners,
  }) async {
    final partnersData =
        await ref.read(partnerControllerProvider.notifier).getPartners(
              PagingModel(),
              context,
            );

    partners.value = partnersData;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // init
    final size = MediaQuery.sizeOf(context);
    final partners = useState<List<PartnerModel>>([]);
    final state = ref.watch(partnerControllerProvider);
    final isRefresh = useState(false);

    // first build
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await fetchData(
          ref: ref,
          context: context,
          partners: partners,
        );
      });

      return null;
    }, [isRefresh.value]);

    return Scaffold(
      backgroundColor: AssetsConstants.whiteColor,
      appBar: const CustomAppBar(
        backButtonColor: AssetsConstants.whiteColor,
        title: 'Đối Tác',
      ),
      body: state.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : partners.value.isEmpty
              ? const Align(
                  alignment: Alignment.topCenter,
                  child: EmptyBox(title: 'Không có tài khoản'),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AssetsConstants.defaultPadding - 8.0,
                  ).copyWith(
                    top: AssetsConstants.defaultPadding - 12.0,
                  ),
                  child: ListView.builder(
                    itemCount: partners.value.length,
                    itemBuilder: (_, index) => PartnerItem(
                      partners: partners,
                      partner: partners.value[index],
                      isRefresh: isRefresh,
                    ),
                  ),
                ),
      floatingActionButton: Visibility(
        visible: !state.isLoading,
        child: SizedBox(
          width: size.width * 0.14,
          height: size.height * 0.07,
          child: FloatingActionButton(
            onPressed: () {
              context.router
                  .push(
                PartnerModifyScreenRoute(type: ModifyType.create),
              )
                  .then((value) {
                if (value != null && value == true) {
                  isRefresh.value = !isRefresh.value;
                }
              });
            },
            child: const Icon(
              Icons.add,
              size: AssetsConstants.defaultFontSize + 10.0,
            ),
          ),
        ),
      ),
    );
  }
}
