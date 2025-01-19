import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/models/item_model.dart';
import 'package:stock_pro/repositories/item_repository.dart';
import 'package:stock_pro/utils/snack_bar_helper.dart';
import 'package:stock_pro/widgets/ongoing_request_dialog.dart';

class AddItemController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final quantityController = TextEditingController();

  bool savingItem = false;

  final ItemRepository _itemRepository = Get.find();

  void addItem() async {
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

      try {
        await _addItemToDatabase();
        savingItem = false;
        update();
        Get.back();

        _resetControllers();
        SnackbarHelper.showSuccess("item_added_successfully".tr);
      } catch (error, stacktrace) {
        print(error);
        print(stacktrace);
        SnackbarHelper.showError("an_error_occurred_during_the_process".tr);
      }
    }
  }

  void _resetControllers() {
    nameController.clear();
    priceController.clear();
    descriptionController.clear();
    quantityController.clear();
  }

  Future<void> _addItemToDatabase() async {
    ItemModel item = ItemModel(
      name: nameController.text,
      price: double.parse(priceController.text),
      description: descriptionController.text,
      quantity: int.parse(quantityController.text),
      createdAt: DateTime.now(),
    );

    _itemRepository.insert(item);
  }
}
