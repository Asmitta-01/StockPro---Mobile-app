import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OwnerHomeController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool addedItem = false,
      madeFirstOperation = false,
      definedStockAlert = false,
      addedManager = false;

  late bool passedAll;

  int? totalItems = 42;
  int? dailyOperations = 13;

  OwnerHomeController() {
    passedAll = passedAllSteps();
  }

  bool passedAllSteps() {
    return addedItem && madeFirstOperation && definedStockAlert && addedManager;
  }

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void goToAddItemView() {
    addedItem = true;
    update();
  }

  void goToAddOperationView() {
    madeFirstOperation = true;
    update();
  }

  void goToDefineAlertView() {
    definedStockAlert = true;
    update();
  }

  void goToAddManagerView() {
    addedManager = true;
    update();
  }

  void closeGettingStarted() {
    passedAll = true;
    update();
  }

  void getPremium() {}
}
