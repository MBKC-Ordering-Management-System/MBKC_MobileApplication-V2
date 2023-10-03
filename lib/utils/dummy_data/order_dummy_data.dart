import 'package:faker/faker.dart';
import '../../features/order/domain/models/order_detail_model.dart';
import '../../features/order/domain/models/order_model.dart';
import '../enums/order_status_type.dart';

OrderStatusType getOrderStatus(int number) {
  if (number % 3 == 0) {
    return OrderStatusType.preparing;
  } else if (number % 5 == 0) {
    return OrderStatusType.ready;
  } else if (number % 7 == 0) {
    return OrderStatusType.delivering;
  } else if (number % 9 == 0) {
    return OrderStatusType.delivered;
  } else {
    return OrderStatusType.cancelled;
  }
}

class OrderDummyData {
  static final ordersGenerate = List.generate(
    50,
    (index) => OrderModel(
      orderid: index + 1,
      partner: faker.company.name(),
      totalItem: faker.randomGenerator.integer(3, min: 1),
      note: '',
      status: OrderStatusType.preparing,
      paymentMethod: index % 2 == 0 ? 'Tiền mặt' : 'Momo',
      customerName: faker.person.name(),
      customerPhone: faker.phoneNumber.us(),
      customerAddress: faker.address.streetAddress(),
      subtotal: faker.randomGenerator.integer(120000, min: 10000),
      discount: faker.randomGenerator.integer(20000, min: 5000),
      finalTotal: faker.randomGenerator.integer(120000, min: 10000),
      orderDetails: List.generate(
        index % 2 == 0 ? 2 : 3,
        (index) => OrderDetailModel(
          productId: index,
          productName: faker.food.cuisine(),
          extra: ['Ít đường', 'Nhiều topping'],
          note: 'Shop cho em xin 5 quả trứng',
          quantity: faker.randomGenerator.integer(3, min: 1),
          totalPrice: faker.randomGenerator.integer(100000, min: 10000),
        ),
      ),
    ),
  );
}
