import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SnackbarType {
  success,
  error,
  info,
}

class SnackbarHelper {
  static void show({
    required String message,
    required SnackbarType type,
    Duration? duration,
  }) {
    Get.showSnackbar(
      GetSnackBar(
        message: message.tr,
        icon: _getIcon(type),
        backgroundColor: _getBackgroundColor(type),
        duration: duration ?? const Duration(seconds: 3),
        onTap: (snack) => Get.closeCurrentSnackbar(),
        margin: const EdgeInsets.all(8),
        borderRadius: 8,
        snackPosition: SnackPosition.TOP,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutCirc,
        reverseAnimationCurve: Curves.easeInCirc,
      ),
    );
  }

  static Icon _getIcon(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return Icon(Icons.check_circle_outline,
            color: Get.theme.colorScheme.onPrimary);
      case SnackbarType.error:
        return Icon(Icons.error_outline, color: Get.theme.colorScheme.onError);
      case SnackbarType.info:
        return Icon(Icons.info_outline,
            color: Get.theme.colorScheme.onSecondary);
    }
  }

  static Color _getBackgroundColor(SnackbarType type) {
    final theme = Get.theme;

    switch (type) {
      case SnackbarType.success:
        return theme.colorScheme.primary;
      case SnackbarType.error:
        return theme.colorScheme.error;
      case SnackbarType.info:
        return theme.colorScheme.secondary;
    }
  }

  // Convenience methods
  static void showSuccess(String message, {Duration? duration}) {
    show(
      message: message,
      type: SnackbarType.success,
      duration: duration,
    );
  }

  static void showError(String message, {Duration? duration}) {
    show(
      message: message,
      type: SnackbarType.error,
      duration: duration,
    );
  }

  static void showInfo(String message, {Duration? duration}) {
    show(
      message: message,
      type: SnackbarType.info,
      duration: duration,
    );
  }
}
