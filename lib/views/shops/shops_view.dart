import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/controllers/shops/shops_controller.dart';
import 'package:stock_pro/utils/image_data.dart';
import 'package:stock_pro/widgets/drawer_widget.dart';
import 'package:stock_pro/widgets/list_tiles/shop_list_tile.dart';

class ShopsView extends GetView<ShopsController> {
  const ShopsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopsController>(builder: (controller) {
      return Scaffold(
        key: controller.scaffoldKey,
        appBar: AppBar(
          title: Text('my_shops'.tr),
          leading: InkWell(
            onTap: controller.openDrawer,
            child: const Icon(Icons.menu_rounded),
          ),
        ),
        drawerEnableOpenDragGesture: true,
        drawer: DrawerWidget(
          currentPage: controller.pagePosition,
          scaffoldKey: controller.scaffoldKey,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            buildBanner(),
            const SizedBox(height: 16),
            addNewShopButton(),
            Container(
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.error.withOpacity(.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                "creating_new_stores_is_not_supported_on_version_of_the_application"
                    .tr,
                style: Get.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Get.theme.colorScheme.error,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "check_your_shop_list".tr,
              style: Get.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            buildShopList(),
          ],
        ),
      );
    });
  }

  Widget buildBanner() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(ImageData.shopsBanner),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  Widget addNewShopButton() => ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          side: const BorderSide(color: Colors.transparent),
        ),
        child: Text('add_new_shop'.tr),
      );

  Widget buildShopList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.shops.length,
      separatorBuilder: (context, index) => const Divider(height: .1),
      itemBuilder: (context, index) {
        var shop = controller.shops[index];
        return ShopListTile(
          shop: shop,
          setAsActive: () => controller.setShopAsActive(shop.id),
        );
      },
    );
  }
}
