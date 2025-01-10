import 'package:get/get.dart';
import 'package:stock_pro/routes.dart';

class SplashController extends GetxController {
  bool checkedStatus = false;
  SplashController() {
    _checkLoginStatus();
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

  Future _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 3), () {
      checkedStatus = true;
      update();
    });
  }
}
