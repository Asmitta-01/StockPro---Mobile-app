import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/models/item.dart';
import 'package:stock_pro/routes.dart';

class ItemsController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final int pagePosition = 2;

  List<Item> items = [];

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void goToAddItemScreen() {
    Get.toNamed(Routes.addItem);
  }
}
