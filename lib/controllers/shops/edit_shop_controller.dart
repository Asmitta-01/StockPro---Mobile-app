import 'package:get/get.dart';
import 'package:stock_pro/models/shop_model.dart';
import 'package:stock_pro/repositories/shop_repository.dart';
import 'package:stock_pro/utils/snack_bar_helper.dart';

class EditShopController extends GetxController {
  bool updatingShop = false;
  late ShopModel shop;

  final ShopRepository _shopRepository = Get.find();

  EditShopController() {
    shop = Get.arguments;
  }

  void updateShop(String name, String? website, String address) async {
    shop.name = name;
    shop.website = website;
    shop.address = address;

    updatingShop = true;
    update();

    try {
      await _shopRepository.update(shop, 'id = ?', [shop.id]);
      SnackbarHelper.showSuccess("shop_updated".tr);
    } catch (e) {
      Get.log(e.toString(), isError: true);
      SnackbarHelper.showError("an_error_occurred_during_the_process".tr);
    }

    updatingShop = false;
    update();
  }
}
