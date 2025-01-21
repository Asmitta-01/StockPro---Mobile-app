import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_pro/models/faq_item_model.dart';
import 'package:stock_pro/utils/constants.dart';
import 'package:stock_pro/utils/snack_bar_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final int pagePosition = 7;

  final SharedPreferences prefs = Get.find();

  final List<FAQItemModel> items = [
    FAQItemModel(
      question:
          'Quels types d\'entreprises peuvent bénéficier de cette application ?',
      answer:
          'Cette application Android est conçue pour les entreprises de toutes tailles, y compris les détaillants, les grossistes et les petites entreprises.',
    ),
    FAQItemModel(
      question:
          'Puis-je suivre différents types d\'inventaire avec cette application ?',
      answer:
          'Oui, vous pouvez facilement ajouter, modifier et supprimer des articles d\'inventaire de différents types dans l\'application.',
    ),
    FAQItemModel(
        question: "How does the app help me manage stock levels?",
        answer:
            "The app allows you to monitor stock levels in real-time, set low-stock alerts, and receive notifications when stock levels fall below a certain threshold."),
    FAQItemModel(
      question: 'Comment sauvegarder et restaurer mes données ?',
      answer:
          'L\'application propose une fonctionnalité de sauvegarde automatique dans le cloud. Vous pouvez également effectuer des sauvegardes manuelles et les restaurer à tout moment.',
    ),
    FAQItemModel(
      question: 'Comment contacter le service client en cas de problème ?',
      answer:
          'Vous pouvez nous contacter par email à l\'adresse tiwabrayan@gmail.com ou consulter notre centre d\'aide en ligne.',
    ),
    FAQItemModel(
      question: 'Comment suis-je informé des mises à jour de l\'application ?',
      answer:
          'Vous recevrez des notifications lorsque de nouvelles mises à jour seront disponibles sur le Google Play Store.',
    ),
  ];

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
