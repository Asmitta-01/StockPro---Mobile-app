import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/models/enums/operation_type.dart';
import 'package:stock_pro/models/enums/transport_method.dart';
import 'package:stock_pro/models/item_model.dart';
import 'package:stock_pro/models/operation_model.dart';
import 'package:stock_pro/models/transport_model.dart';
import 'package:stock_pro/repositories/item_repository.dart';
import 'package:stock_pro/repositories/operation_repository.dart';
import 'package:stock_pro/utils/snack_bar_helper.dart';
import 'package:stock_pro/widgets/ongoing_request_dialog.dart';

class AddOperationController extends GetxController {
  final OperationRepository _repository = Get.find();
  final ItemRepository _itemRepository = Get.find();

  final formKey = GlobalKey<FormState>();
  final invoiceController = TextEditingController();
  final amountController = TextEditingController();
  final commentController = TextEditingController();
  final dateController =
      TextEditingController(text: DateTime.now().toString().split(" ")[0]);
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

      OperationModel operation = OperationModel(
        invoiceNumber: invoiceController.text,
        amount: double.parse(amountController.text),
        comment: commentController.text,
        createdAt: DateTime.parse(dateController.text),
        type: OperationType.fromString(typeController.text),
        id: 0,
        transport: TransportModel(
          TransportMethod.fromString(transportTypeController.text),
          double.tryParse(transportCostController.text) ?? 0.0,
        ),
      );
      operation.items = _itemsXQuantity;

      try {
        await _repository.insert(operation);
        _clearFields();
        Get.back(closeOverlays: true);
        SnackbarHelper.showSuccess("operation_saved".tr);
      } catch (e, stackTrace) {
        Get.back();
        debugPrint(e.toString());
        debugPrint(stackTrace.toString());
        SnackbarHelper.showError("an_error_occurred_during_the_process".tr);
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
