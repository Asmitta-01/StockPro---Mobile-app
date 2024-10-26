import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stock_pro/routes.dart';

class SignUpController extends GetxController {
  final pageController = PageController(keepPage: false);
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPwdController = TextEditingController();
  final emailKey = GlobalKey<FormFieldState>();
  final nameKey = GlobalKey<FormFieldState>();
  final birthdayKey = GlobalKey<FormFieldState>();
  final passwordKey = GlobalKey<FormFieldState>();
  final confirmPwdKey = GlobalKey<FormFieldState>();

  bool passwordVisible = false;
  bool signingUp = false, checkingEmail = false;
  int currentPage = 0, totalPages = 5;

  void togglePasswordVisibility() {
    passwordVisible = !passwordVisible;
    update();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "please_fill_this_field".tr;
    } else if (!value.isEmail) {
      return "enter_a_valid_email".tr;
    }
    return null;
  }

  String? validateField(String? value) {
    if (value == null || value.isEmpty) {
      return "please_fill_this_field".tr;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "please_fill_this_field".tr;
    } else if (value.isAlphabetOnly) {
      return "the_password_should_contain_a_number".tr;
    } else if (value.length < 6) {
      return "it_should_have_at_least_six_characters".tr;
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "please_fill_this_field".tr;
    } else if (value != passwordController.text) {
      return "this_field_should_be_equal_to_the_password".tr;
    }
    return null;
  }

  void selectDate() async {
    var initialDate = DateTime.now().subtract(const Duration(days: 365 * 10));
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: initialDate,
      firstDate: DateTime(1950),
      lastDate: initialDate,
    );
    if (picked != null) {
      birthdayController.text =
          DateFormat('dd MMMM yyyy', Get.locale?.toString()).format(picked);
    }
  }

  void switchPage([bool nextPage = true]) async {
    if (nextPage) {
      if (!await _validatePageInput() || currentPage == totalPages - 1) return;
      currentPage++;
    } else {
      if (currentPage == 0) return;
      currentPage--;
    }

    pageController.animateToPage(
      currentPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInQuart,
    );
    Future.delayed(const Duration(milliseconds: 300), () {
      update();
    });
  }

  Future<bool> _validatePageInput() async {
    switch (currentPage) {
      case 0:
        if (emailKey.currentState!.validate()) {
          checkingEmail = true;
          update();
          return await Future.delayed(const Duration(seconds: 2), () {
            checkingEmail = false;
            update();
            return true;
          });
        } else {
          return false;
        }
      case 1:
        return nameKey.currentState!.validate();
      case 2:
        return birthdayKey.currentState!.validate();
      case 3:
        return passwordKey.currentState!.validate();
      case 4:
        if (confirmPwdKey.currentState!.validate()) {
          _signUp();
          return true;
        }
        return false;
      default:
        return true;
    }
  }

  void _signUp() {
    signingUp = true;
    update();
    Future.delayed(const Duration(seconds: 3), () {
      signingUp = false;
      update();
      Get.offNamed(Routes.accountComplete);
    });
  }

  void goBack() {
    if (currentPage == 0) {
      Get.back();
    } else {
      switchPage(false);
    }
  }

  void goToLoginScreen() {
    Get.offNamed(Routes.login);
  }

  @override
  void onClose() {
    emailController.dispose();
    birthdayController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmPwdController.dispose();
    super.onClose();
  }
}
