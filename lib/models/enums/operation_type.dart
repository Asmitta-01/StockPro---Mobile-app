import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/utils/image_data.dart';

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

  Widget icon([double size = 60]) {
    switch (this) {
      case OperationType.incoming:
        return ImageIcon(
          const AssetImage(ImageData.operationIn),
          size: size,
          color: Get.theme.colorScheme.primary,
        );
      case OperationType.outgoing:
        return ImageIcon(
          const AssetImage(ImageData.operationIn),
          size: size,
          color: Get.theme.colorScheme.secondary,
        );
      case OperationType.transfer:
        return Icon(
          Icons.sync_alt,
          size: size,
          color: Get.theme.colorScheme.onSurface,
        );
    }
  }
}
