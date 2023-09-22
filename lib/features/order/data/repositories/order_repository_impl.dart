import '../../../../models/order_model.dart';
import '../../../../models/paging_model.dart';
import '../../../../utils/commons/functions/delay_util.dart';
import '../../../../utils/dummy_data/order_dummy_data.dart';
import '../../../../utils/resources/remote_base_repository.dart';
import '../../domain/repositories/order_repository.dart';

class OrderRepositoryImpl extends RemoteBaseRepository
    implements OrderRepository {
  final bool addDelay;
  OrderRepositoryImpl({this.addDelay = true});

  @override
  Future<List<OrderModel>> getOrders(PagingModel page) async {
    await delay(addDelay);
    return OrderDummyData.ordersGenerate
        .skip((page.pageNumber - 1) * page.pageSize)
        .take(page.pageSize)
        .toList();
  }
}
