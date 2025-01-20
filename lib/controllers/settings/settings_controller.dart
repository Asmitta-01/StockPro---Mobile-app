import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/controllers/my_controller.dart';
import 'package:stock_pro/routes.dart';
import 'package:stock_pro/utils/constants.dart';
import 'package:stock_pro/widgets/bottom_sheets/language_bottom_sheet.dart';
import 'package:stock_pro/widgets/theme_picker_dialog.dart';

class SettingsController extends GetxController {
  final MyController _myController = Get.find();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final int pagePosition = 8;
  late List<Map<String, dynamic>> items;

  SettingsController() {
    _initializeData();
  }

  void _initializeData() {
    items = [
      {
        'label': 'edit_your_informations',
        'icon': Icons.manage_accounts_outlined,
        'subtitle': null,
        'action': navigateToProfile
      },
      {
        'label': 'notifications',
        'icon': Icons.edit_notifications_outlined,
        'subtitle': null,
        'action': () {}
      },
      {
        'label': 'language',
        'icon': Icons.language_outlined,
        'subtitle': _getCurrentLanguage,
        'action': _showLanguageBottomSheet
      },
      {
        'label': 'theme',
        'icon': Icons.dark_mode_outlined,
        'subtitle': _getThemeMode,
        'action': _showThemeDialog
      },
      {
        'label': 'terms_of_use',
        'icon': Icons.article_outlined,
        'subtitle': null,
        'action': () => Get.toNamed("Routes.about")
      },
      {
        'label': 'privacy_policy',
        'icon': Icons.security,
        'subtitle': null,
        'action': () => Get.toNamed("Routes.about")
      }
    ];
    update();
  }

  Future<void> navigateToProfile() async {
    final result = await Get.toNamed("");

    if (result == true) {
      _initializeData();
    }
  }

  String _getThemeMode() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      update();
    });
    return _myController.themeMode == ThemeMode.system
        ? 'system_theme'.tr
        : _myController.themeMode == ThemeMode.light
            ? 'light_theme'.tr
            : 'dark_theme'.tr;
  }

  String _getCurrentLanguage() => AppConstants.languages
      .firstWhere((l) => l.languageCode == Get.locale?.languageCode)
      .languageName!;

  _showLanguageBottomSheet() => Get.bottomSheet(
        LanguageBottomSheetWidget(),
        settings: const RouteSettings(name: '${Routes.settings}/language'),
      );
  _showThemeDialog() => Get.dialog(
        ThemePickerDialog(),
        routeSettings: const RouteSettings(name: '${Routes.settings}/theme'),
      );

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }
}
