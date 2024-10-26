import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/controllers/home/manager_home_controller.dart';

class ManagerHomeScreen extends GetView<ManagerHomeController> {
  const ManagerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManagerHomeController>(
      builder: (controller) {
        return Scaffold(
          key: controller.scaffoldKey,
          drawerEnableOpenDragGesture: true,
          drawer: Container(),
          appBar: AppBar(
            shadowColor: Get.theme.colorScheme.onSurface.withAlpha(100),
            foregroundColor: Get.theme.colorScheme.onSurface.withAlpha(224),
            backgroundColor: Get.theme.colorScheme.surface,
            leading: InkWell(
              onTap: controller.openDrawer,
              child: const Icon(Icons.menu_rounded),
            ),
            title: Text("home".tr),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 16),
                child: InkWell(child: Icon(Icons.notifications_outlined)),
              )
            ],
          ),
        );
      },
    );
  }
}
