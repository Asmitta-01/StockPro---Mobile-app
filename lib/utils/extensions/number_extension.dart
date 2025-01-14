import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension NumberExtension on num {
  String get toCurrency => NumberFormat.compactSimpleCurrency(
          locale: Get.locale?.languageCode, name: 'XAF')
      .format(this);

  String get compact =>
      NumberFormat.compact(locale: Get.locale?.languageCode).format(this);
}
