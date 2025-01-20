import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:stock_pro/models/shop_model.dart';
import 'package:stock_pro/repositories/shop_repository.dart';
import 'package:stock_pro/routes.dart';
import 'package:stock_pro/utils/constants.dart';
import 'package:stock_pro/utils/snack_bar_helper.dart';

class SplashController extends GetxController {
  final ShopRepository _shopRepository = Get.find();

  bool checkedStatus = false;
  SplashController() {
    _initialize().then((_) => _checkShop());
  }

  void goToMainView() {
    Get.toNamed(Routes.main);
  }

  void handlePopScope() {
    Get.back(closeOverlays: checkedStatus);
  }

  Future<void> _initialize() async {
    for (var element in AppConstants.languages) {
      await initializeDateFormatting(
          '${element.languageCode!}_ ${element.countryCode!}', null);
    }
  }

  Future _checkShop() async {
    await Future.delayed(const Duration(seconds: 2));

    var shops = await _shopRepository.getAll();
    if (shops.isNotEmpty) {
      goToMainView();
      return;
    }

    checkedStatus = true;
    update();
  }

  void createShop(String name, String? website, String address) async {
    ShopModel shopModel = ShopModel(
      name: name,
      website: website,
      address: address,
      createdAt: DateTime.now(),
      categories: [],
      active: true,
      id: 0,
    );

    try {
      await _shopRepository.insert(shopModel);
      SnackbarHelper.showSuccess("shop_added".tr);
      goToMainView();
    } catch (e) {
      debugPrint(e.toString());
      SnackbarHelper.showError("an_error_occurred_during_the_process".tr);
    }
  }
}
