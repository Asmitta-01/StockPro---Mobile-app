import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:stock_pro/controllers/splash_controller.dart';
import 'package:stock_pro/utils/image_data.dart';
import 'package:stock_pro/widgets/forms/shop_form.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: controller.checkedStatus,
      onPopInvokedWithResult: (didPop, result) => controller.handlePopScope(),
      child: Scaffold(
        backgroundColor: Get.isDarkMode
            ? Get.theme.colorScheme.surface
            : Get.theme.colorScheme.primary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: min(400, Get.size.width),
                height: min(400, Get.size.width),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage(
                      Get.isDarkMode
                          ? ImageData.logoDark
                          : ImageData.logoBlueBackground,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              GetBuilder<SplashController>(builder: (controller) {
                if (controller.checkedStatus) {
                  return ElevatedButton(
                    onPressed: () {
                      _showBottomSheet(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Get.theme.colorScheme.surface,
                      foregroundColor: Get.theme.colorScheme.primary,
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.size.width * .25),
                    ),
                    child: Text('start'.tr),
                  );
                } else {
                  return LoadingAnimationWidget.staggeredDotsWave(
                    color: Get.theme.colorScheme.onPrimary,
                    size: 38,
                  );
                }
              }),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      backgroundColor: Get.isDarkMode
          ? Get.theme.colorScheme.surfaceContainer
          : Get.theme.colorScheme.surface,
      sheetAnimationStyle: AnimationStyle(
        curve: Curves.easeIn,
        duration: const Duration(seconds: 1),
      ),
      enableDrag: false,
      isScrollControlled: true,
      builder: (context) => IntrinsicHeight(
        child: Padding(
          padding: MediaQuery.of(context)
              .viewInsets
              .copyWith(left: 24, right: 24, top: 24),
          child: Column(
            children: [
              Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.onSurface,
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                ),
              ),
              const SizedBox(height: 18),
              ShopForm(fn: controller.createShop),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}
