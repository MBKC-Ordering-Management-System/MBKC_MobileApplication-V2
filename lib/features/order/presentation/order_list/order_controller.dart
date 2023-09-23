import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../models/order_model.dart';
import '../../../../models/request/paging_model.dart';
import '../../../../utils/enums/order_status_type.dart';
import '../../domain/repositories/order_repository.dart';

part 'order_controller.g.dart';

@riverpod
class OrderController extends _$OrderController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  // get orders
  Future<List<OrderModel>> getOrders(
    int pageNum,
    OrderStatusType orderType,
  ) async {
    List<OrderModel> orders = [];
    state = const AsyncLoading();
    final orderRepository = ref.read(orderRepositoryProvider);
    final request = PagingModel(pageNumber: pageNum);

    state = await AsyncValue.guard(
      () async {
        orders = await orderRepository.getOrders(request, orderType);
      },
    );

    if (state.hasError) {}

    return orders;
  }
}
