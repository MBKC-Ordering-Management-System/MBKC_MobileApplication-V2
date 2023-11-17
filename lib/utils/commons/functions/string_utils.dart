import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';
import '../../enums/enums_export.dart';

String calculateMD5(String input) {
  var bytes = utf8.encode(input); // Encode the input string to bytes
  var digest = md5.convert(bytes); // Calculate the MD5 hash
  return digest.toString(); // Convert the MD5 hash to a string
}

String getCustomContent(Map<String, dynamic> content) {
  switch (content.entries.first.key) {
    case 'Mã:':
      return '#${content.entries.first.value}';

    case 'Tiền nhận:':
      final number =
          NumberFormat.decimalPattern().format(content.entries.first.value);
      return '+ $numberđ';

    case 'Tiền rút:':
    case 'Giảm giá:':
      if ((content.entries.first.value as int) == 0) {
        final number =
            NumberFormat.decimalPattern().format(content.entries.first.value);
        return '$numberđ';
      }
      final number =
          NumberFormat.decimalPattern().format(content.entries.first.value);
      return '- $numberđ';

    case 'Giá cũ:':
    case 'Giá giảm giá:':
    case 'Giá bán:':
    case 'Số tiền giao dịch':
    case 'Số dư sau giao dịch':
    case 'Giá:':
    case 'Số tiền:':
    case 'Tạm tính:':
    case 'Phí giao hàng:':
    case 'Tổng cộng:':
    case 'Phí đơn hàng:':
    case 'Tiền thu hộ:':
    case 'doanh thu:':
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

String getTitleTypeMoneyExchange(MoneyExchangeType type) {
  switch (type) {
    case MoneyExchangeType.receive:
      return 'Tiền nhận';
    case MoneyExchangeType.withdraw:
      return 'Tiền rút';
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
      return 'Hoàn thành';
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
      return 'Hoàn thành';
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

String getStatusPaymentMethod(bool isPaid) {
  switch (isPaid) {
    case true:
      return 'Đã thanh toán';
    case false:
      return 'Chưa thanh toán';

    default:
      return 'Unknow!';
  }
}

String getTitleMoneyExchangeType(MoneyExchangeType type) {
  switch (type) {
    case MoneyExchangeType.all:
      return 'Tất cả';
    case MoneyExchangeType.receive:
      return 'Tiền nhận';
    case MoneyExchangeType.withdraw:
      return 'Tiền rút';

    default:
      return 'Unknow!';
  }
}

String getTitleCategoryType(CategoryType type) {
  switch (type) {
    case CategoryType.normal:
      return 'Danh mục thường';
    case CategoryType.extra:
      return 'Danh mục thêm';
    default:
      return 'Unknow!';
  }
}

String getTitleStatusMoneyExchange(String status) {
  switch (status) {
    case 'Success':
      return 'Thành công';
    case 'Fail':
      return 'Thất bại';
    default:
      return 'Unknow!';
  }
}

String getContentMoneyExchange(MoneyExchangeType type) {
  switch (type) {
    case MoneyExchangeType.receive:
      return 'Nhận tiền đơn hàng trong ngày từ bếp trung tâm';
    case MoneyExchangeType.withdraw:
      return 'Rút tiền từ số dư của ví';
    default:
      return 'Unknow!';
  }
}
