import 'dart:ui';

import 'package:get/get.dart';

enum OperationType {
  incoming,
  outgoing,
  transfer;

  static OperationType fromString(String type) {
    switch (type) {
      case 'incoming':
        return OperationType.incoming;
      case 'outgoing':
        return OperationType.outgoing;
      case 'transfer':
        return OperationType.transfer;
      default:
        return OperationType.incoming;
    }
  }

  Color get color {
    switch (this) {
      case OperationType.incoming:
        return Get.theme.colorScheme.primary;
      case OperationType.outgoing:
        return Get.theme.colorScheme.secondary;
      case OperationType.transfer:
        return Get.theme.colorScheme.onSurface;
    }
  }
}
