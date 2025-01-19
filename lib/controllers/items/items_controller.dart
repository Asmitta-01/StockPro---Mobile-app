import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/models/item_model.dart';
import 'package:stock_pro/repositories/item_repository.dart';
import 'package:stock_pro/routes.dart';

class ItemsController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final int pagePosition = 2;

  bool loadingItems = true;
  final ItemRepository _repository = Get.find();

  List<ItemModel> selectedItems = [];
  List<ItemModel> items = [];

  ItemsController() {
    _loadItems();
  }

  void _loadItems() async {
    items = await _repository.getAll().catchError((_) {
      Get.snackbar('Error', 'Failed to load items');
      return <ItemModel>[];
    });
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

  void goToItemDetailsView(ItemModel item) {
    // Get.toNamed(Routes.itemDetails, arguments: item);
  }
}
