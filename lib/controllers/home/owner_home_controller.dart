import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_pro/models/operation_model.dart';
import 'package:stock_pro/repositories/item_repository.dart';
import 'package:stock_pro/repositories/operation_repository.dart';
import 'package:stock_pro/routes.dart';
import 'package:stock_pro/utils/constants.dart';
import 'package:stock_pro/utils/snack_bar_helper.dart';

class OwnerHomeController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final ItemRepository _itemRepository = Get.find();
  final OperationRepository _operationRepository = Get.find();
  final SharedPreferences prefs = Get.find();

  bool definedStockAlert = false;
  bool justOpened = true;

  late bool passedAll;

  List<OperationModel> latestOperations = [];
  final int limit = 2;

  int totalItems = 0;
  int totalOperations = 0;
  int? dailyOperations = 0;

  bool get addedItem => totalItems > 0;
  bool get madeFirstOperation => totalOperations > 0;
  bool get readFAQ => !(prefs.getBool(AppConstants.firstTimeHelp) ?? true);

  OwnerHomeController() {
    _initialize();
    passedAll = passedAllSteps();
    justOpened = false;
  }

  void _initialize() async {
    try {
      totalItems = (await _itemRepository.getAll()).length;

      final operations = await _operationRepository.getAll();
      latestOperations = operations.take(limit).toList();
      totalOperations = operations.length;
      dailyOperations = operations
          .where(
              (model) => DateUtils.isSameDay(model.createdAt, DateTime.now()))
          .length;

      definedStockAlert = (await _itemRepository
              .query(where: 'stock_threshold <> ?', whereArgs: [0]))
          .isNotEmpty;
    } catch (e) {
      debugPrint(e.toString());
      SnackbarHelper.showError("an_error_occurred_during_the_process".tr);
    }

    if (passedAllSteps()) {
      passedAll = true;
    }

    justOpened = false;
    update();
  }

  bool passedAllSteps() {
    return addedItem && madeFirstOperation && definedStockAlert && readFAQ;
  }

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void goToAddItemView() {
    if (!addedItem) {
      Get.toNamed(Routes.addItem)?.then((_) {
        _initialize();
      });
    }
  }

  void goToAddOperationView() {
    if (!madeFirstOperation) {
      Get.toNamed(Routes.addOperation)?.then((_) {
        _initialize();
      });
    }
  }

  void goToDefineAlertView() {
    if (!definedStockAlert) {
      Get.toNamed(Routes.items, arguments: {'definedStockAlert': true});
    }
  }

  void goToFAQView() {
    if (!readFAQ) {
      Get.toNamed(Routes.help);
    }
  }

  void closeGettingStarted() {
    passedAll = true;
    update();
  }
}
