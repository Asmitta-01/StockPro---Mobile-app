import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:stock_pro/controllers/shops/edit_shop_controller.dart';
import 'package:stock_pro/widgets/forms/shop_form.dart';

class EditShopView extends GetView<EditShopController> {
  const EditShopView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditShopController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('edit_shop'.tr),
            actions: [
              IconButton(
                onPressed: null,
                icon: controller.updatingShop
                    ? LoadingAnimationWidget.staggeredDotsWave(
                        color: Get.theme.colorScheme.onSurface, size: 16)
                    : const SizedBox.shrink(),
              ),
            ],
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: ShopForm(
                fn: controller.updateShop,
                shopModel: controller.shop,
              ),
            ),
          ),
        );
      },
    );
  }
}
