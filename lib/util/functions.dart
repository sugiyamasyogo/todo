import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String convertDateTimeToString(DateTime datetime) {
  return DateFormat.yMd("ja").format(datetime);
}