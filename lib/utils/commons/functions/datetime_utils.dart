import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<String> dateTimePicker(BuildContext context) async {
  final DateTime? dateTime = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1970),
    lastDate: DateTime(2500),
  );

  if (dateTime != null) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  return '';
}

DateTime stringToDateTime(String time) {
  try {
    DateFormat format = DateFormat('dd-MM-yyyy');
    return format.parse(time);
  } catch (ex) {
    throw Exception('Exception when parsing from String to Datetime');
  }
}
