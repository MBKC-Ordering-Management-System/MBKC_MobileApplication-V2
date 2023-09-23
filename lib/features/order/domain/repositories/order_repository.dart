import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../models/order_model.dart';
import '../../../../models/request/paging_model.dart';
import '../../../../utils/enums/order_status_type.dart';
import '../../data/repositories/order_repository_impl.dart';

part 'order_repository.g.dart';

abstract class OrderRepository {
  Future<List<OrderModel>> getOrders(
    PagingModel request,
    OrderStatusType orderType,
  );
}

@Riverpod(keepAlive: true)
OrderRepository orderRepository(OrderRepositoryRef ref) {
  return OrderRepositoryImpl();
}
