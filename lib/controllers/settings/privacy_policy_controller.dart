import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stock_pro/utils/snack_bar_helper.dart';

class PrivacyPolicyController extends GetxController {
  String privacyPolicy = '';
  bool hasError = false;
  bool isLoading = true;

  PrivacyPolicyController() {
    String locale = Get.locale?.languageCode ?? 'en';

    rootBundle
        .loadString('assets/data/privacy_policy/privacy.$locale.md')
        .then((value) {
      privacyPolicy = value;
      update();
    }).catchError((_) {
      hasError = true;
      update();
    }).whenComplete(() {
      isLoading = false;
      update();
    });
  }

  void share() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/privacy_policy.md');
      await file.writeAsString(privacyPolicy);
      await Share.shareXFiles([XFile(file.path)], text: 'privacy_policy'.tr);
    } catch (e) {
      Get.log(e.toString(), isError: true);
      SnackbarHelper.showError("failed_to_share_file");
    }
  }
}
