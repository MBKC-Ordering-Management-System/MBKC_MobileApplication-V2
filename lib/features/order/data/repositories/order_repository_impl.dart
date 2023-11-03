import '../../../../models/response/success_model.dart';
import '../../../../models/request/paging_model.dart';
import '../../../../utils/commons/functions/delay_util.dart';
import '../../../../utils/constants/api_constant.dart';
import '../../../../utils/resources/remote_base_repository.dart';
import '../../domain/models/response/order_list_response.dart';
import '../../domain/repositories/order_repository.dart';
import '../remote/order_source.dart';

class OrderRepositoryImpl extends RemoteBaseRepository
    implements OrderRepository {
  final bool addDelay;
  final OrderSource _orderSource;
  OrderRepositoryImpl(this._orderSource, {this.addDelay = true});

  @override
  Future<OrderListResponse> getOrders({
    required PagingModel request,
    required String accessToken,
  }) {
    return getDataOf(
      request: () => _orderSource.getOrders(
        APIConstants.contentType,
        accessToken,
        request.filterSystemContent,
        request.filterContent,
        request.pageNumber,
        request.pageSize,
      ),
    );
  }

  @override
  Future<SuccessModel> confirmOrder(int id) async {
    await delay(addDelay);
    return SuccessModel(message: 'Update successfully.');
  }
}
