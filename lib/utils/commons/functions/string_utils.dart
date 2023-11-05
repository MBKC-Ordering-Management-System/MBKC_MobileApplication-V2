import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';
import '../../enums/enums_export.dart';
import '../../enums/order_system_status_type.dart';
import '../../enums/product_type_enum.dart';
import '../../enums/sort_type_enum.dart';

String calculateMD5(String input) {
  var bytes = utf8.encode(input); // Encode the input string to bytes
  var digest = md5.convert(bytes); // Calculate the MD5 hash
  return digest.toString(); // Convert the MD5 hash to a string
}

String getCustomContent(Map<String, dynamic> content) {
  switch (content.entries.first.key) {
    case 'Mã:':
      return '#${content.entries.first.value}';

    case 'Tiền vào:':
      final number =
          NumberFormat.decimalPattern().format(content.entries.first.value);
      return '+ $numberđ';

    case 'Tiền ra:':
    case 'Giảm giá:':
      final number =
          NumberFormat.decimalPattern().format(content.entries.first.value);
      return '- $numberđ';

    case 'Giá cũ':
    case 'Giá giảm giá':
    case 'Giá bán':
    case 'Số tiền giao dịch':
    case 'Số dư sau giao dịch':
    case 'Giá:':
    case 'Số tiền:':
    case 'Tạm tính:':
    case 'Phí giao hàng:':
    case 'Tổng cộng:':
      final number =
          NumberFormat.decimalPattern().format(content.entries.first.value);
      return '$numberđ';

    default:
      return content.entries.first.value.toString();
  }
}

String getTitlePartner(PartnerType type) {
  switch (type) {
    case PartnerType.beamin:
      return 'Beamin';
    case PartnerType.grabfood:
      return 'GrabFood';
    case PartnerType.shopeefood:
      return 'ShopeeFood';
    default:
      return 'Beamin';
  }
}

String getTitleStatus(String status) {
  switch (status) {
    case 'Active':
      return 'Hoạt động';
    case 'Inactive':
      return 'Dừng hoạt động';
    case 'Deactive':
      return 'Đóng cửa';
    default:
      return 'Undefine';
  }
}

String getTitleTypeTransaction(TransactionType type) {
  switch (type) {
    case TransactionType.moneyin:
      return 'Tiền vào';
    case TransactionType.moneyout:
      return 'Tiền ra';
    default:
      return 'Unknow!';
  }
}

String getTitleProductType(ProductType type) {
  switch (type) {
    case ProductType.single:
      return 'Đơn';
    case ProductType.parent:
      return 'Cha';
    case ProductType.child:
      return 'Con';
    case ProductType.extra:
      return 'Thêm';
    default:
      return 'Unknow!';
  }
}

String getTitleSortType(SortType type) {
  switch (type) {
    case SortType.asc:
      return 'Tăng dần';
    case SortType.desc:
      return 'Giảm dần';
    default:
      return 'Unknow!';
  }
}

String getTitleSystemStatus(OrderSystemStatusType type) {
  switch (type) {
    case OrderSystemStatusType.instore:
      return 'Trong bếp';
    case OrderSystemStatusType.readydelivery:
      return 'Sẵn sàng giao';
    case OrderSystemStatusType.completed:
      return 'Đã giao';
    case OrderSystemStatusType.cancelled:
      return 'Đã hủy';
    default:
      return 'Unknow!';
  }
}

String getTitlePartnerStatus(OrderPartnerStatusType type) {
  switch (type) {
    case OrderPartnerStatusType.preparing:
      return 'Đang chuẩn bị';
    case OrderPartnerStatusType.upcoming:
      return 'Đặt trước';
    case OrderPartnerStatusType.ready:
      return 'Sẵn sàng';
    case OrderPartnerStatusType.completed:
      return 'Đã giao';
    case OrderPartnerStatusType.cancelled:
      return 'Đã hủy';
    default:
      return 'Unknow!';
  }
}

String getTitlePaymentMethod(String type) {
  switch (type) {
    case 'Cash':
      return 'Tiền mặt';
    case 'Cashless':
      return 'Chuyển khoản';

    default:
      return 'Unknow!';
  }
}
