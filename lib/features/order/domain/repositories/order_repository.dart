import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../models/order_model.dart';
import '../../../../models/paging_model.dart';
import '../../data/repositories/order_repository_impl.dart';

part 'order_repository.g.dart';

abstract class OrderRepository {
  Future<List<OrderModel>> getOrders(PagingModel request);
}

@Riverpod(keepAlive: true)
OrderRepository orderRepository(OrderRepositoryRef ref) {
  return OrderRepositoryImpl();
}

@riverpod
Future<List<OrderModel>> getOrders(GetOrdersRef ref, PagingModel request) {
  final orderRepository = ref.read(orderRepositoryProvider);
  return orderRepository.getOrders(request);
}
