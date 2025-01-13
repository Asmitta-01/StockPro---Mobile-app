import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/models/shop_model.dart';
import 'package:stock_pro/routes.dart';
import 'package:stock_pro/utils/image_data.dart';
import 'package:stock_pro/widgets/shop_bottom_sheet.dart';

class ShopListTile extends StatelessWidget {
  const ShopListTile({
    super.key,
    required this.shop,
    this.setAsActive,
  });

  final ShopModel shop;
  final void Function()? setAsActive;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(shop.name),
      subtitle: Text(shop.categories.join(', ')),
      leading: shop.logo != null && shop.logo!.isNotEmpty
          ? Image.network(shop.logo!)
          : Image.asset(!Get.isDarkMode ? ImageData.shop : ImageData.shopDark),
      trailing: shop.active
          ? Icon(Icons.check_circle, color: Get.theme.colorScheme.primary)
          : null,
      tileColor:
          shop.active ? Get.theme.colorScheme.primary.withOpacity(.1) : null,
      titleTextStyle:
          Get.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
      onTap: () {
        Get.bottomSheet(
          ShopBottomSheet(
            shopModel: shop,
            onTapActive: setAsActive,
          ),
          isScrollControlled: true,
          settings: RouteSettings(
              name: Routes.singleShop.replaceFirst(':id', "${shop.id}")),
        );
      },
    );
  }
}
