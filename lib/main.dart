import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:stock_pro/controllers/my_controller.dart';
import 'package:stock_pro/routes.dart';
import 'package:stock_pro/utils/constants.dart';
import 'package:stock_pro/utils/get_di.dart';
import 'package:stock_pro/utils/messages.dart';
import 'package:stock_pro/utils/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  for (var element in AppConstants.languages) {
    await initializeDateFormatting(
        '${element.languageCode!}_ ${element.countryCode!}', null);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyController>(builder: (controller) {
      return GetMaterialApp(
        title: AppConstants.appName,
        initialRoute: Routes.splash,
        translations: Messages(languages: controller.translations),
        locale: controller.locale,
        fallbackLocale: Locale(
          AppConstants.languages[0].languageCode!,
          AppConstants.languages[0].countryCode,
        ),
        defaultTransition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 500),
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme,
        darkTheme: AppTheme.appThemeDark,
        themeMode: ThemeMode.system,
      );
    });
  }
}
