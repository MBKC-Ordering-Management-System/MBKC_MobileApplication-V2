import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../models/response/success_model.dart';
import '../../../../models/request/paging_model.dart';
import '../../data/remote/order_source.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../models/order_model.dart';
import '../models/request/reason.dart';
import '../models/response/order_list_response.dart';

part 'order_repository.g.dart';

abstract class OrderRepository {
  Future<OrderListResponse> getOrders({
    required PagingModel request,
    required String accessToken,
  });

  Future<OrderModel> getOrderDetail({
    required int orderId,
    required String accessToken,
  });

  Future<SuccessModel> confirmOrder({
    required int orderId,
    required String accessToken,
  });

  Future<SuccessModel> cancelOrder({
    required Reason reason,
    required int orderId,
    required String accessToken,
  });
}

@Riverpod(keepAlive: true)
OrderRepository orderRepository(OrderRepositoryRef ref) {
  final orderSource = ref.read(orderSourceProvider);
  return OrderRepositoryImpl(orderSource);
}
