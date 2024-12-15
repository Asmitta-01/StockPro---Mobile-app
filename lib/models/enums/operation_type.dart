import 'dart:ui';

import 'package:get/get.dart';

enum OperationType {
  incoming,
  outgoing,
  transfer;

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
