import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stock_pro/routes.dart';
import 'package:stock_pro/utils/constants.dart';
import 'package:stock_pro/utils/image_data.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget(
      {super.key, required this.currentPage, required this.scaffoldKey});

  final int currentPage;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    Future<PackageInfo> packageInfo = PackageInfo.fromPlatform();

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: buildDrawerHeader(),
          ),
          Expanded(
            flex: Get.size.height < 700 ? 3 : 5,
            child: getDrawerItemsList(),
          ),
          Expanded(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Image.asset(ImageData.logo, width: 90),
                  const SizedBox(width: 12),
                  FutureBuilder(
                    future: packageInfo,
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? Text(
                              "v${snapshot.data!.version}",
                              style: Get.textTheme.bodySmall,
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  ListView getDrawerItemsList() {
    const divider = Divider(height: 10, thickness: 8);
    return ListView(
      padding: const EdgeInsets.only(bottom: 8),
      // physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        divider,
        _singleDrawerItem(Icons.dashboard, "home".tr, Routes.main, 1),
        divider,
        _singleDrawerItem(Icons.storage_rounded, "items".tr, Routes.items, 2),
        _singleDrawerItem(
            Icons.sync_alt, "operations".tr, Routes.operations, 3),
        // _singleDrawerItem(Icons.notifications_rounded, "notifications".tr,
        //     Routes.notifications, 4),
        _singleDrawerItem(Icons.store_rounded, "my_shops".tr, Routes.shops, 5),
        _singleDrawerItem(
            Icons.document_scanner_rounded, "reports".tr, Routes.reports, 6),
        divider,
        _singleDrawerItem(
            Icons.help, "help_and_suggestions".tr, Routes.help, 7),
        _singleDrawerItem(
            Icons.build_outlined, "settings".tr, Routes.settings, 8),
      ],
    );
  }

  DrawerHeader buildDrawerHeader() {
    return DrawerHeader(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      margin: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Get.theme.cardColor,
            ),
            child: Image.asset(ImageData.appIcon, width: 80),
          ),
          const SizedBox(height: 8.0),
          Text(AppConstants.appName, style: Get.textTheme.titleLarge),
          Text(
            "offline_version".tr,
            style: TextStyle(
              color: Get.theme.colorScheme.onSurface.withAlpha(150),
            ),
          )
        ],
      ),
    );
  }

  Widget _singleDrawerItem(
      IconData iconData, String title, String destination, int position) {
    ThemeData theme = Get.theme;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Icon(
        iconData,
        size: 23,
        color: currentPage == position
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurface,
      ),
      title: Text(
        title,
        style: Get.textTheme.bodyMedium!.copyWith(
          fontWeight:
              currentPage == position ? FontWeight.w600 : FontWeight.w400,
          color: currentPage == position
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurface,
        ),
      ),
      dense: true,
      onTap: () {
        if (currentPage != position) {
          Get.offNamed(destination);
        }
        scaffoldKey.currentState?.closeDrawer();
      },
    );
  }
}
