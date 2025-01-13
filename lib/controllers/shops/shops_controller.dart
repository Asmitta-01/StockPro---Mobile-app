import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/models/shop_model.dart';

class ShopsController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final int pagePosition = 5;

  final List<ShopModel> shops = [
    ShopModel(
      id: 1,
      name: "ABC Quincaillerie",
      image: "https://picsum.photos/500",
      logo: "",
      categories: ["Health", "Office"],
      createdAt: DateTime.now(),
    ),
    ShopModel(
      id: 2,
      name: "Supérette DNY",
      image: "https://picsum.photos/400",
      logo: "",
      active: true,
      categories: ["Grocery", "Bakery", "Dairy"],
      createdAt: DateTime.now(),
    ),
    ShopModel(
      id: 3,
      name: "Pharmacie de la cote",
      image: "https://picsum.photos/500",
      logo: "",
      categories: ["Pharmacy"],
      createdAt: DateTime.now(),
    ),
  ];

  void setShopAsActive(int id) {
    for (var shop in shops) {
      if (shop.id == id) {
        shop.active = true;
      } else {
        shop.active = false;
      }
      update();
    }
    Get.back();
  }

  void addNewShop() {
    Get.showSnackbar(
      GetSnackBar(
        message: "can_not_perform_this_action_now".tr,
        icon: Icon(
          Icons.block,
          color: Get.theme.colorScheme.onError,
        ),
        backgroundColor: Get.theme.colorScheme.error,
        duration: const Duration(seconds: 3),
        onTap: (snack) => Get.closeCurrentSnackbar(),
      ),
    );
  }

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }
}
