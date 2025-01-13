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
            const SizedBox(height: 16),
            Text(
              "check_your_shop_list".tr,
              style: Get.textTheme.titleLarge,
            ),
            Text(
              "explore_new_options".tr,
              style: Get.textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.w300),
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
      onPressed: controller.addNewShop, child: Text('add_new_shop'.tr));

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
