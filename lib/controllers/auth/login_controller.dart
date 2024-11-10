import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/models/helpers/language_model.dart';
import 'package:stock_pro/routes.dart';
import 'package:stock_pro/utils/constants.dart';

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

  void goToRegisterScreen() {
    Get.toNamed(Routes.signUp);
  }

  void goToForgotPasswordScreen() {}

  @override
  void onClose() {
    formKey.currentState?.reset();
    super.onClose();
  }
}
