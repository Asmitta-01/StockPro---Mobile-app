import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:stock_pro/routes.dart';
import 'package:stock_pro/utils/constants.dart';

class SplashController extends GetxController {
  bool checkedStatus = false;
  SplashController() {
    _initialize().then((_) => _checkLoginStatus());
  }

  void goToLoginView() {
    Get.close(1);
    Get.toNamed(Routes.login);
  }

  void goToSignUpView() {
    Get.toNamed(Routes.signUp);
  }

  void handlePopScope() {
    if (checkedStatus) {
      Get.back(closeOverlays: true);
    } else {
      Get.back();
    }
  }

  Future<void> _initialize() async {
    for (var element in AppConstants.languages) {
      await initializeDateFormatting(
          '${element.languageCode!}_ ${element.countryCode!}', null);
    }
  }

  Future _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2), () {
      checkedStatus = true;
      update();
    });
  }
}
