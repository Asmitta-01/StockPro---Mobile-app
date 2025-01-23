import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_pro/models/faq_item_model.dart';
import 'package:stock_pro/repositories/faq_item_repository.dart';
import 'package:stock_pro/utils/constants.dart';
import 'package:stock_pro/utils/snack_bar_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final int pagePosition = 7;

  final FaqItemRepository _repository = Get.find();

  final SharedPreferences prefs = Get.find();

  List<FAQItemModel> items = [];

  HelpController() {
    if (prefs.getBool(AppConstants.firstTimeHelp) ?? true) {
      prefs.setBool(AppConstants.firstTimeHelp, false);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 500), () {
          SnackbarHelper.showInfo(
            'consult_our_faqs_regularly'.tr,
            icon: Icons.help_outline_outlined,
          );
        });
      });
    }
    _loadItems();
  }

  void _loadItems() async {
    try {
      items = await _repository.getAll();
      update();
    } catch (_) {
      SnackbarHelper.showError('error_loading_faqs'.tr);
    }
  }

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void showSendMailConfirmDialog() {
    Get.defaultDialog(
      title: 'contact_us'.tr,
      middleText: "${"send_a_mail_at_@x".trParams({
            'x': AppConstants.appSupportMail
          })} ?",
      textConfirm: 'continue'.tr,
      textCancel: 'cancel'.tr,
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        _launchEmail();
      },
      onCancel: Get.back,
    );
  }

  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: AppConstants.appSupportMail,
      queryParameters: {'subject': 'support_request'.tr, 'body': ''},
    );

    try {
      // Don't call canLaunch for mailto links - use it only for http and https!
      // Link: https://stackoverflow.com/a/71081003/13808068
      // if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
      // } else {
      // throw 'Could not launch $emailLaunchUri';
      // }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: "An error occurred while launching client".tr,
        icon: Icon(
          Icons.mail_lock_outlined,
          color: Get.theme.colorScheme.onSecondary,
        ),
        backgroundColor: Get.theme.colorScheme.secondary,
        duration: const Duration(seconds: 3),
        onTap: (snack) => Get.closeCurrentSnackbar(),
      ));
    }
  }
}
