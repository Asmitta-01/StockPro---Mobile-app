import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stock_pro/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_pro/utils/theme.dart';

class MyController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;
  MyController({required this.sharedPreferences}) {
    loadCurrentLanguage();
    loadTranslations();
  }

  Locale _locale = Locale(AppConstants.languages[0].languageCode!,
      AppConstants.languages[0].countryCode);
  Locale get locale => _locale;

  Map<String, Map<String, String>> translations = {};
  Future<void> loadTranslations() async {
    Map<String, Map<String, String>> langs = {};
    final languageCodes = AppConstants.languages
        .map((lang) => '${lang.languageCode}_${lang.countryCode}')
        .toList();
    final jsonFiles = await Future.wait(AppConstants.languages.map((lang) =>
        rootBundle.loadString('assets/languages/${lang.languageCode}.json')));

    for (int i = 0; i < languageCodes.length; i++) {
      langs[languageCodes[i]] = jsonDecode(jsonFiles[i]).cast<String, String>();
    }

    translations = langs;
    update();
  }

  void setLanguage(Locale locale, {bool fromBottomSheet = false}) {
    Get.updateLocale(locale);
    _locale = locale;

    if (!fromBottomSheet) {
      _saveLanguage(_locale);
    }

    update();
  }

  void loadCurrentLanguage() {
    _locale = _getLocaleFromSharedPref();
    update();
  }

  Locale _getLocaleFromSharedPref() {
    return Locale(
      sharedPreferences.getString(AppConstants.languageCode) ??
          AppConstants.languages[0].languageCode!,
      sharedPreferences.getString(AppConstants.countryCode) ??
          AppConstants.languages[0].countryCode,
    );
  }

  void _saveLanguage(Locale locale) {
    sharedPreferences.setString(AppConstants.languageCode, locale.languageCode);
    sharedPreferences.setString(AppConstants.countryCode, locale.countryCode!);
  }

  ThemeData getThemeData() {
    return Get.isDarkMode ? AppTheme.appThemeDark : AppTheme.appTheme;
  }
}
