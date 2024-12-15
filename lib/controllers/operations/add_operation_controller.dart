import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/widgets/ongoing_request_dialog.dart';

class AddOperationController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final invoiceController = TextEditingController();
  final amountController = TextEditingController();
  final commentController = TextEditingController();
  final dateController = TextEditingController();
  final typeController = TextEditingController();

  bool savingOperation = false;

  void addOperation() async {
    if (formKey.currentState!.validate()) {
      Get.dialog(
        PopScope(
          canPop: false,
          child: OngoingRequestDialog(text: 'saving_operation'.tr),
        ),
        barrierDismissible: false,
        name: "Dialog - ${'saving_operation'.tr}",
      );

      savingOperation = true;
      update();
      Future.delayed(const Duration(seconds: 3), () {
        savingOperation = false;
        update();
        Get.back();

        Get.showSnackbar(GetSnackBar(
          message: "operation_saved".tr,
          icon: Icon(
            Icons.check_circle_outline,
            color: Get.theme.colorScheme.onPrimary,
          ),
          backgroundColor: Get.theme.colorScheme.primary,
          duration: const Duration(seconds: 3),
          onTap: (snack) => Get.closeCurrentSnackbar(),
        ));
      });
    }
  }
}
