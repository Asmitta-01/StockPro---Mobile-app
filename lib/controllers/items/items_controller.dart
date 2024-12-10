import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/models/item.dart';
import 'package:stock_pro/routes.dart';

class ItemsController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final int pagePosition = 2;

  List<Item> selectedItems = [];

  List<Item> items = [
    Item(
      id: 1,
      name: 'Clou de diamètre 100',
      price: 100,
      quantity: 10,
      description:
          'Clou provenant des agences de fabrication de fers du pays. Il ne rouille pas.',
    ),
    Item(
      id: 2,
      name: 'Sac de ciment',
      price: 6000,
      quantity: 20,
      description: 'This is item 2',
    ),
    Item(
      id: 3,
      name: 'Barre de fer de diamètre 12',
      price: 3000,
      quantity: 30,
      description: 'This is item 3',
    ),
  ];

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void selectItem(Item item) {
    selectedItems.add(item);
    update();
  }

  void removeSelectedItem(Item item) {
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

  void goToAddItemScreen() {
    Get.toNamed(Routes.addItem);
  }

  void goToItemDetailsScreen(Item item) {
    // Get.toNamed(Routes.itemDetails, arguments: item);
  }
}
