import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/widgets/ongoing_request_dialog.dart';

class AddItemController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final quantityController = TextEditingController();

  bool savingItem = false;

  void addItem() {
    if (formKey.currentState!.validate()) {
      Get.dialog(
        PopScope(
          canPop: false,
          child: OngoingRequestDialog(text: 'saving_item'.tr),
        ),
        barrierDismissible: false,
        name: "Dialog - ${'saving_item'.tr}",
      );

      savingItem = true;
      update();
      Future.delayed(const Duration(seconds: 3), () {
        savingItem = false;
        update();
        Get.back();

        Get.showSnackbar(GetSnackBar(
          message: "item_added_successfully".tr,
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
