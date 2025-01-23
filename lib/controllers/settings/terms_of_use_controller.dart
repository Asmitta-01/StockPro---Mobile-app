import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TermsOfUseController extends GetxController {
  String termsOfUse = '';
  bool hasError = false;
  bool isLoading = true;

  TermsOfUseController() {
    String locale = Get.locale?.languageCode ?? 'en';

    rootBundle
        .loadString('assets/data/terms_of_use/terms.$locale.md')
        .then((value) {
      termsOfUse = value;
      update();
    }).catchError((_) {
      hasError = true;
      update();
    }).whenComplete(() {
      isLoading = false;
      update();
    });
  }
}
