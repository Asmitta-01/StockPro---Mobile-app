import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/models/item_model.dart';
import 'package:stock_pro/routes.dart';

class ItemsController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final int pagePosition = 2;

  List<ItemModel> selectedItems = [];

  List<ItemModel> items = [
    ItemModel(
      id: 1,
      name: 'Clou de diamètre 100',
      price: 100,
      quantity: 10,
      description:
          'Clou provenant des agences de fabrication de fers du pays. Il ne rouille pas.',
    ),
    ItemModel(
      id: 2,
      name: 'Sac de ciment',
      price: 6000,
      quantity: 20,
      description: 'This is item 2',
    ),
    ItemModel(
      id: 3,
      name: 'Barre de fer de diamètre 12',
      price: 3000,
      quantity: 30,
      description: 'This is item 3',
    ),
    ItemModel(
      id: 4,
      name: 'Barre de fer de diamètre 16',
      price: 4000,
      quantity: 40,
      description: 'This is item 4',
    ),
    ItemModel(
      id: 5,
      name: 'Barre de fer de diamètre 20',
      price: 5000,
      quantity: 50,
      description: 'This is item 5',
    ),
    ItemModel(
      id: 6,
      name: 'Barre de fer de diamètre 25',
      price: 6000,
      quantity: 10,
      description: 'This is item 6',
    ),
  ];

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
    Get.toNamed(Routes.addItem);
  }

  void goToItemDetailsView(ItemModel item) {
    // Get.toNamed(Routes.itemDetails, arguments: item);
  }
}
