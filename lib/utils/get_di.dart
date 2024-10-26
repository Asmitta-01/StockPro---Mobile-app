import 'package:get/get.dart';
import 'package:stock_pro/controllers/my_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  MyController appController = MyController(sharedPreferences: Get.find());
  await appController.loadTranslations();
  Get.lazyPut(() => appController);
}
