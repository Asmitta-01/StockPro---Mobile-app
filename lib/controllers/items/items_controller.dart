import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stock_pro/models/item_model.dart';
import 'package:stock_pro/repositories/helpers/database_exception_handler.dart';
import 'package:stock_pro/repositories/item_repository.dart';
import 'package:stock_pro/routes.dart';
import 'package:stock_pro/utils/snack_bar_helper.dart';
import 'package:stock_pro/widgets/bottom_sheets/item_bottom_sheet.dart';
import 'package:stock_pro/widgets/dialogs/ongoing_request_dialog.dart';

class ItemsController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final int pagePosition = 2;

  bool loadingItems = true;
  final ItemRepository _repository = Get.find();

  List<ItemModel> selectedItems = [];
  List<ItemModel> items = [];

  ItemsController() {
    _loadItems().then((_) {
      var args = Get.arguments;
      if (args != null && args['definedStockAlert'] == true) {
        _showItemWithNoThreshold();
      }
    });
  }

  Future<void> _loadItems() async {
    items = await _repository.getAll().catchError((_) {
      return <ItemModel>[];
    });
    items.sort((a, b) => a.name.compareTo(b.name));
    loadingItems = false;
    update();
  }

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void selectItem(ItemModel item) {
    selectedItems.add(item);
    update();
  }

  void removeSelectedItem(ItemModel item) {
    selectedItems.remove(item);
    update();
  }

  void selectAllItems() {
    selectedItems.clear();
    selectedItems.addAll(items);
    update();
  }

  void clearSelection() {
    selectedItems.clear();
    update();
  }

  void deleteSelectedItems() {
    items.removeWhere((item) => selectedItems.contains(item));
    selectedItems.clear();
    update();
  }

  void goToAddItemView() {
    Get.toNamed(Routes.addItem)?.then((_) {
      loadingItems = true;
      update();
      _loadItems();
    });
  }

  void goToEditItemView(ItemModel item) {
    Get.toNamed(
      Routes.editItem.replaceFirst(':id', item.id.toString()),
      arguments: item,
    )?.then((_) {
      loadingItems = true;
      update();
      _loadItems();
    });
  }

  void _showItemWithNoThreshold() {
    final item =
        items.firstWhereOrNull((element) => element.stockThreshold == 0);
    if (item == null) return;

    Get.bottomSheet(
      ItemBottomSheet(
        item: item,
        onUpdateThreshold: updateThreshold,
      ),
      isScrollControlled: true,
      settings: RouteSettings(
          name: Routes.singleItem.replaceFirst(':id', "${item.id}")),
    );
  }

  void updateThreshold(ItemModel item, int threshold) async {
    if (item.stockThreshold == threshold) {
      return;
    }

    _showLoader('updating_item'.tr);

    item.stockThreshold = threshold;
    try {
      await _repository.update(item, "id = ?", [item.id]);
      items[items.indexWhere((element) => element.id == item.id)] = item;
      SnackbarHelper.showSuccess(
        "threshold_updated_successfully".tr,
        duration: const Duration(seconds: 2),
      );
      if (Get.isOverlaysOpen) Get.close(1);
    } on DatabaseException catch (e) {
      DatabaseExceptionHandler.handleException(e);
    } catch (_) {
      SnackbarHelper.showError("failed_to_update_threshold".tr);
    } finally {
      update();
      _hideLoader();
    }
  }

  void _showLoader(String text) {
    Get.dialog(
      PopScope(
        canPop: false,
        child: OngoingRequestDialog(text: text),
      ),
      barrierDismissible: false,
      name: "Dialog - $text",
    );
  }

  void _hideLoader() => Get.close(1);
}
