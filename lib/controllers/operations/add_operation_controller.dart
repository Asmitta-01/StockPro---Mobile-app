import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stock_pro/models/enums/operation_type.dart';
import 'package:stock_pro/models/enums/transport_method.dart';
import 'package:stock_pro/models/item_model.dart';
import 'package:stock_pro/models/operation_model.dart';
import 'package:stock_pro/models/transport_model.dart';
import 'package:stock_pro/repositories/helpers/database_exception_handler.dart';
import 'package:stock_pro/repositories/item_repository.dart';
import 'package:stock_pro/repositories/operation_repository.dart';
import 'package:stock_pro/utils/snack_bar_helper.dart';
import 'package:stock_pro/widgets/dialogs/ongoing_request_dialog.dart';

class AddOperationController extends GetxController {
  final OperationRepository _repository = Get.find();
  final ItemRepository _itemRepository = Get.find();

  final formKey = GlobalKey<FormState>();
  final invoiceController = TextEditingController();
  final amountController = TextEditingController();
  final commentController = TextEditingController();
  final dateController = TextEditingController(text: DateTime.now().toString());
  final typeController = TextEditingController();
  final transportCostController = TextEditingController();
  final transportTypeController = TextEditingController();
  Map<ItemModel, int> _itemsXQuantity = {};

  bool savingOperation = false;

  List<ItemModel> items = [];

  AddOperationController() {
    _loadItems();
  }

  void _loadItems() async {
    items = await _itemRepository.getAll();
    update();
  }

  void addOperation() async {
    if (formKey.currentState!.validate() && _validateItems()) {
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

      String invoiceNumber = invoiceController.text.isEmpty
          ? 'SP${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}'
          : invoiceController.text;

      OperationModel operation = OperationModel(
        invoiceNumber: invoiceNumber,
        amount: double.parse(amountController.text),
        comment: commentController.text,
        createdAt: DateTime.parse(dateController.text),
        type: OperationType.fromString(typeController.text),
        transport: transportTypeController.text.isEmpty
            ? null
            : TransportModel(
                TransportMethod.fromString(transportTypeController.text),
                double.tryParse(transportCostController.text) ?? 0.0,
              ),
      );
      operation.items = _itemsXQuantity;

      if (_checkQuantities(operation)) {
        try {
          await _repository.insert(operation);
          _updateItemsQuantityInDatabase(operation);
          _clearFields();
          Get.back(closeOverlays: true);
          SnackbarHelper.showSuccess("operation_saved".tr);
        } on DatabaseException catch (dbError) {
          Get.back();
          DatabaseExceptionHandler.handleException(dbError);
        } catch (e) {
          Get.back();
          Get.log(e.toString(), isError: true);
          SnackbarHelper.showError("an_error_occurred_during_the_process".tr);
        }
      }

      savingOperation = false;
      update();
    }
  }

  bool _validateItems() {
    if (_itemsXQuantity.isEmpty) {
      SnackbarHelper.showError("please_add_items".tr);
      return false;
    }
    return true;
  }

  /// Validates if there is sufficient quantity available for each item in
  /// an outgoing operation
  ///
  /// Returns `true` if all items have sufficient quantity, `false` otherwise
  /// Shows an error snackbar if any item has insufficient quantity
  bool _checkQuantities(OperationModel operation) {
    if (operation.type == OperationType.outgoing) {
      for (var entry in operation.items.entries) {
        if (entry.key.quantity < entry.value) {
          SnackbarHelper.showError("not_enough_quantity".tr);
          return false;
        }
      }
    }
    return true;
  }

  /// Updates item quantities in the database based on operation type
  ///
  /// For incoming operations: Increases the item quantity
  /// For outgoing operations: Decreases the item quantity
  /// For transfer operations: No quantity changes (early return)
  ///
  /// Parameters:
  ///   operation - The [OperationModel] containing the type and items to update
  void _updateItemsQuantityInDatabase(OperationModel operation) {
    if (operation.type == OperationType.transfer) return;

    operation.items.forEach((item, qty) {
      if (operation.type == OperationType.incoming) {
        item.quantity += qty;
      } else {
        item.quantity -= qty;
      }
      _itemRepository.update(item, "id = ?", [item.id]);
    });
  }

  void _clearFields() {
    invoiceController.clear();
    amountController.clear();
    commentController.clear();
    transportCostController.clear();
    transportTypeController.clear();
    dateController.clear();
    _itemsXQuantity.clear();
  }

  void updateItemsXQuantity(Map<ItemModel, int> map) {
    _itemsXQuantity = map;
    update();
  }
}
