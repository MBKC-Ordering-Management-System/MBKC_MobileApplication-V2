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

    case 'Tiền vào:':
      final number =
          NumberFormat.decimalPattern().format(content.entries.first.value);
      return '+ $numberđ';

    case 'Tiền ra:':
    case 'Giảm giá:':
      final number =
          NumberFormat.decimalPattern().format(content.entries.first.value);
      return '- $numberđ';

    case 'Số tiền giao dịch':
    case 'Số dư sau giao dịch':
    case 'Giá:':
    case 'Tạm tính:':
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
    case 'active':
      return 'Hoạt động';
    case 'inactive':
      return 'Dừng hoạt động';
    case 'deactive':
      return 'Đóng cửa';
    default:
      return 'undefine';
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
