import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:stock_pro/controllers/splash_controller.dart';
import 'package:stock_pro/routes.dart';
import 'package:stock_pro/utils/image_data.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
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
                  if (Get.routing.current == Routes.splash) {
                    // ignore: use_build_context_synchronously
                    Future.microtask(() => _showBottomSheet(context));
                  }
                  return Container();
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 28),
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Get.theme.colorScheme.onPrimary,
                      size: 38,
                    ),
                  );
                }
              }),
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
      constraints: BoxConstraints(maxHeight: Get.size.height * .3),
      backgroundColor: Get.isDarkMode
          ? Get.theme.colorScheme.surfaceContainer
          : Get.theme.colorScheme.surface,
      isDismissible: false,
      barrierColor: Colors.transparent,
      sheetAnimationStyle: AnimationStyle(
        curve: Curves.easeIn,
        duration: const Duration(seconds: 1),
      ),
      enableDrag: false,
      builder: (context) => IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(ImageData.google, height: 24),
                          const SizedBox(width: 4),
                          Text(
                            'continue_with_google'.tr,
                            style: const TextStyle(fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: controller.goToSignUpScreen,
                      child: Text(
                        'continue_with_email'.tr,
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Divider(),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: controller.goToLoginScreen,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.mail_outline_sharp),
                          const SizedBox(width: 4),
                          Text(
                            'login'.tr,
                            style: const TextStyle(fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
