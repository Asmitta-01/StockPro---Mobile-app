import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stock_pro/models/item_model.dart';
import 'package:stock_pro/repositories/helpers/database_exception_handler.dart';
import 'package:stock_pro/repositories/item_repository.dart';
import 'package:stock_pro/utils/snack_bar_helper.dart';
import 'package:stock_pro/widgets/dialogs/ongoing_request_dialog.dart';

class EditItemController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final quantityController = TextEditingController();

  bool updatingItem = false;
  late ItemModel item;

  final ItemRepository _itemRepository = Get.find();

  EditItemController() {
    item = Get.arguments;
    nameController.text = item.name;
    priceController.text = item.price.toString();
    descriptionController.text = item.description;
    quantityController.text = item.quantity.toString();
  }

  void updateItem() async {
    if (formKey.currentState!.validate()) {
      Get.dialog(
        PopScope(
          canPop: false,
          child: OngoingRequestDialog(text: 'updating_item'.tr),
        ),
        barrierDismissible: false,
        name: "Dialog - ${'updating_item'.tr}",
      );

      updatingItem = true;
      update();

      try {
        await _updateItemToDatabase();
        updatingItem = false;
        update();
        Get.back();

        SnackbarHelper.showSuccess(
          "item_updated_successfully".tr,
          duration: const Duration(seconds: 2),
        );
      } on DatabaseException catch (e) {
        Get.back();
        DatabaseExceptionHandler.handleException(e);
      } catch (error) {
        Get.back();
        Get.log(error.toString(), isError: true);
        SnackbarHelper.showError("an_error_occurred_during_the_process".tr);
      }
    }
  }

  Future<void> _updateItemToDatabase() async {
    item.name = nameController.text;
    item.price = double.parse(priceController.text);
    item.description = descriptionController.text;
    item.quantity = int.parse(quantityController.text);

    _itemRepository.update(item, "id = ?", [item.id]);
  }
}
