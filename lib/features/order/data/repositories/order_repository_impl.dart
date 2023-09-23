import '../../../../models/order_model.dart';
import '../../../../models/request/paging_model.dart';
import '../../../../utils/commons/functions/delay_util.dart';
import '../../../../utils/dummy_data/order_dummy_data.dart';
import '../../../../utils/enums/order_status_type.dart';
import '../../../../utils/resources/remote_base_repository.dart';
import '../../domain/repositories/order_repository.dart';

class OrderRepositoryImpl extends RemoteBaseRepository
    implements OrderRepository {
  final bool addDelay;
  OrderRepositoryImpl({this.addDelay = true});

  @override
  Future<List<OrderModel>> getOrders(
    PagingModel page,
    OrderStatusType orderType,
  ) async {
    await delay(addDelay);
    return OrderDummyData.ordersGenerate
        .where((item) => item.status == orderType)
        .skip((page.pageNumber - 1) * page.pageSize)
        .take(page.pageSize)
        .toList();
  }
}
