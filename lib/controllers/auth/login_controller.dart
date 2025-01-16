import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/models/helpers/language_model.dart';
import 'package:stock_pro/routes.dart';
import 'package:stock_pro/utils/constants.dart';
import 'package:stock_pro/widgets/language_bottom_sheet.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool passwordVisible = false, loggingIn = false;

  void togglePasswordVisibility() {
    passwordVisible = !passwordVisible;
    update();
  }

  String? validateField(String? value) {
    return null;
  }

  LanguageModel getSelectedLanguageModel() {
    return AppConstants.languages.firstWhere(
        (element) => element.languageCode == Get.locale!.languageCode);
  }

  showLanguageBottomSheet() => Get.bottomSheet(
        LanguageBottomSheetWidget(),
        settings: const RouteSettings(name: '${Routes.settings}/language'),
      );

  void login() {
    loggingIn = true;
    update();
    Future.delayed(const Duration(seconds: 4), () {
      loggingIn = false;
      update();

      bool accountComplete = Random().nextBool();
      if (!accountComplete) {
        Get.toNamed(Routes.accountComplete);
      } else {
        Get.toNamed(Routes.main);
      }
    });
  }

  void goToRegisterView() {
    Get.toNamed(Routes.signUp);
  }

  void goToForgotPasswordView() {}

  @override
  void onClose() {
    formKey.currentState?.reset();
    super.onClose();
  }
}
