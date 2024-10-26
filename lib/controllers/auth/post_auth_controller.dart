import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/routes.dart';
import 'package:stock_pro/widgets/dialogs.dart';
import 'package:stock_pro/widgets/forms/shop_form.dart';

class PostAuthController extends GetxController {
  int totalPages = 3, currentPage = 0;
  PageController pageController = PageController();

  List<String> roles = ['Proprio', 'Gérant'];
  String selectedRole = 'Gérant';

  List<String> genders = ['Male', 'Female'];
  String selectedGender = 'Male';

  bool savedShop = false;
  bool checkingToken = false;
  TextEditingController tokenController = TextEditingController();

  void updateSelectedRole(String? value) {
    if (value != null) {
      selectedRole = value;
      update();
    }
  }

  void updateSelectedGender(String? value) {
    if (value != null) {
      selectedGender = value;
      update();
    }
  }

  void switchPage([bool nextPage = true]) {
    if (nextPage) {
      if (currentPage == totalPages - 1) return;
      currentPage++;
    } else {
      if (currentPage == 0) return;
      currentPage--;
    }

    pageController.animateToPage(
      currentPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    Future.delayed(const Duration(milliseconds: 300), () {
      update();
    });
  }

  String? validateTokenInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'please_fill_this_field'.tr;
    }
    return null;
  }

  void showShopFormSheet() {
    Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: IntrinsicHeight(
            child: Column(
          children: [
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.onSurface,
                borderRadius: const BorderRadius.all(Radius.circular(40)),
              ),
            ),
            const SizedBox(height: 18),
            ShopForm(fn: (_, __, ___) {
              Get.back();
            }),
          ],
        )),
      ),
      backgroundColor: Get.theme.colorScheme.surface,
      enableDrag: false,
    );
  }

  void checkToken() async {
    checkingToken = true;
    update();

    await Future.delayed(const Duration(seconds: 3));

    checkingToken = false;
    update();

    Get.offAllNamed(Routes.main);
  }

  void close() {
    showActionDialog(
      Get.context!,
      title: "cancel_the_config".tr,
      primaryAction: _signOut,
      secondaryAction: Get.back,
      primaryActionLabel: "yes_cancel".tr,
      secondaryActionLabel: "no_finish_the_setup".tr,
      content:
          "if_you_cancel_the_account_setup_process_you_will_be_logged_out".tr,
      isDanger: true,
    );
  }

  void completeAccount() {}

  void _signOut() {
    Get.offAllNamed(Routes.splash);
  }
}
