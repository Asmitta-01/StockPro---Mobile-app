import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/controllers/settings/settings_controller.dart';
import 'package:stock_pro/widgets/drawer_widget.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      builder: (controller) {
        return Scaffold(
          key: controller.scaffoldKey,
          appBar: AppBar(
            title: Text('settings'.tr),
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
            padding: const EdgeInsets.symmetric(horizontal: 8),
            children: [buildItems()],
          ),
        );
      },
    );
  }

  Widget buildItems() {
    return ListView.separated(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        Map<String, dynamic> item = controller.items[index];
        return ListTile(
          leading: Icon(item['icon']),
          onTap: item['action'],
          title: Text("${item['label']}".tr),
          subtitle: item['subtitle'] != null ? Text(item['subtitle']()) : null,
          trailing: Icon(
            Icons.chevron_right_outlined,
            color: Get.theme.colorScheme.onSurface.withOpacity(.3),
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemCount: controller.items.length,
    );
  }
}
