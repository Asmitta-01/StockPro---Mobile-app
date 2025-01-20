import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/models/operation_model.dart';
import 'package:stock_pro/repositories/operation_repository.dart';
import 'package:stock_pro/routes.dart';
import 'package:stock_pro/utils/snack_bar_helper.dart';

class OperationsController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final int pagePosition = 3;

  final OperationRepository _repository = Get.find();

  bool loadingOperations = true;
  List<OperationModel> operations = [];

  OperationsController() {
    _loadOperations();
  }

  void _loadOperations() async {
    try {
      operations = await _repository.getAll();
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      SnackbarHelper.showError("an_error_occurred_while_loading_data".tr);
    }

    loadingOperations = false;
    update();
  }

  void deleteOperation(int id) async {
    try {
      await _repository.delete("id = ?", [id]);
      operations.removeWhere((element) => element.id == id);
      update();
      SnackbarHelper.showInfo("operation_deleted".tr);
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      SnackbarHelper.showError("an_error_occurred_while_deleting_data".tr);
    }
  }

  Future<bool> showDeleteDialog() async {
    bool? result = await Get.dialog(
      AlertDialog(
        title: Text("delete_operation".tr),
        content: Text("are_you_sure_you_want_to_delete_this_operation".tr),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(result: false);
            },
            child: Text("cancel".tr),
          ),
          TextButton(
            onPressed: () {
              Get.back(result: true);
              // deleteOperation(id);
            },
            child: Text("delete".tr),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void goToAddOperationView() {
    Get.toNamed(Routes.addOperation)?.then((_) {
      loadingOperations = true;
      update();
      _loadOperations();
    });
  }
}
