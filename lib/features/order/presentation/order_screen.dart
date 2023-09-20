import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../utils/commons/widgets/label_text.dart';
import '../../../utils/constants/asset_constant.dart';

@RoutePage()
class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AssetsConstants.mainColor,
          centerTitle: true,
          title: const LabelText(
            content: 'Đơn hàng',
            size: AssetsConstants.defaultFontSize,
            color: AssetsConstants.whiteColor,
            fontWeight: FontWeight.w600,
          ),
          bottom: const TabBar(
            indicatorColor: AssetsConstants.mainColor,
            tabs: [
              Tab(text: 'Tất cả'),
              Tab(text: 'Chuẩn bi'),
              Tab(text: 'Sẵn sàng'),
              Tab(text: 'Sắp tới'),
              Tab(text: 'Lịch sử'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              width: size.width * 0.4,
              height: size.height * 0.4,
              decoration: const BoxDecoration(
                color: AssetsConstants.mainColor,
              ),
            ),
            Container(
              width: size.width * 0.4,
              height: size.height * 0.4,
              decoration: const BoxDecoration(
                color: AssetsConstants.blackColor,
              ),
            ),
            Container(
              width: size.width * 0.4,
              height: size.height * 0.4,
              decoration: const BoxDecoration(
                color: AssetsConstants.warningColor,
              ),
            ),
            Container(
              width: size.width * 0.4,
              height: size.height * 0.4,
              decoration: const BoxDecoration(
                color: AssetsConstants.totalOrderBackground,
              ),
            ),
            Container(
              width: size.width * 0.4,
              height: size.height * 0.4,
              decoration: const BoxDecoration(
                color: AssetsConstants.totalOrderContent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
