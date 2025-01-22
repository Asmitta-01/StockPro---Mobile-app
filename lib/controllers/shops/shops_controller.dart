import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stock_pro/models/shop_model.dart';
import 'package:stock_pro/repositories/helpers/database_exception_handler.dart';
import 'package:stock_pro/repositories/shop_repository.dart';

class ShopsController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final int pagePosition = 5;

  final ShopRepository _repository = Get.find();

  final List<ShopModel> shops = [];

  ShopsController() {
    _loadShops();
  }

  void _loadShops() async {
    try {
      shops.addAll(await _repository.getAll());
      update();
    } on DatabaseException catch (e) {
      DatabaseExceptionHandler.handleException(e);
    }
  }

  void setShopAsActive(int id) {
    for (var shop in shops) {
      if (shop.id == id) {
        shop.active = true;
      } else {
        shop.active = false;
      }
      update();
    }
    Get.back();
  }

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }
}
