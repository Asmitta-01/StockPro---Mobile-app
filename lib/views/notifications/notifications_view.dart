import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/controllers/notifications/notifications_controller.dart';
import 'package:stock_pro/utils/extensions/datetime_extension.dart';
import 'package:stock_pro/utils/image_data.dart';
import 'package:stock_pro/widgets/drawer_widget.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationsController>(builder: (controller) {
      return Scaffold(
        key: controller.scaffoldKey,
        appBar: AppBar(
          title: Text('notifications'.tr),
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
        body: RefreshIndicator(
          onRefresh: () async {},
          color: Get.theme.primaryColor,
          backgroundColor: Get.theme.scaffoldBackgroundColor,
          child: controller.notifications.isNotEmpty
              ? buildNotificationList()
              : buildEmptyWidget(),
        ),
      );
    });
  }

  Widget buildNotificationList() {
    return ListView.separated(
      itemBuilder: (context, index) {
        var notification = controller.notifications[index];
        return ListTile(
          leading: notification.isRead ? null : const Icon(Icons.priority_high),
          title: Text(notification.title),
          subtitle: Text(notification.body),
          trailing: Text(
            notification.date.timeDifference(),
            style: Get.textTheme.bodySmall,
          ),
          visualDensity: VisualDensity.compact,
        );
      },
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemCount: controller.notifications.length,
    );
  }

  Widget buildEmptyWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageIcon(
              const AssetImage(ImageData.notifications),
              size: Get.size.width * 0.4,
            ),
            const SizedBox(height: 20),
            Text(
              "no_notifications".tr,
              style: Get.textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
