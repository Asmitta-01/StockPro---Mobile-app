import 'package:get/get.dart';
import 'package:stock_pro/controllers/my_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_pro/repositories/faq_item_repository.dart';
import 'package:stock_pro/repositories/helpers/app_database_helper.dart';
import 'package:stock_pro/repositories/item_repository.dart';
import 'package:stock_pro/repositories/operation_repository.dart';
import 'package:stock_pro/repositories/shop_repository.dart';

Future init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  MyController appController = MyController(sharedPreferences: Get.find());
  await appController.loadTranslations();
  Get.lazyPut(() => appController);

  ItemRepository itemRepository =
      ItemRepository(dbHelper: AppDatabaseHelper.instance);
  Get.lazyPut(() => itemRepository, fenix: true);

  ShopRepository shopRepository =
      ShopRepository(dbHelper: AppDatabaseHelper.instance);
  Get.lazyPut(() => shopRepository, fenix: true);

  OperationRepository operationRepository =
      OperationRepository(dbHelper: AppDatabaseHelper.instance);
  Get.lazyPut(() => operationRepository, fenix: true);

  FaqItemRepository faqItemRepository = FaqItemRepository.instance;
  Get.lazyPut(() => faqItemRepository, fenix: true);
}
