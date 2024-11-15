import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/routes.dart';
import 'package:stock_pro/utils/image_data.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget(
      {super.key, required this.currentPage, required this.scaffoldKey});

  final int currentPage;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    // Future<PackageInfo> packageInfo = PackageInfo.fromPlatform();

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: buildDrawerHeader(),
          ),
          Expanded(
            flex: 5,
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
                  // FutureBuilder(
                  //   future: packageInfo,
                  //   builder: (context, snapshot) {
                  //     return snapshot.hasData
                  //         ? Text(
                  //             "v${snapshot.data!.version}",
                  //             style: Get.textTheme.bodySmall,
                  //           )
                  //         : SizedBox(
                  //             width: 8,
                  //             height: 2,
                  //             child: LinearProgressIndicator(
                  //               color: theme.colorScheme.onSurface,
                  //               minHeight: 2,
                  //             ),
                  //           );
                  //   },
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  ListView getDrawerItemsList() {
    const divider = Divider(height: 10, thickness: 10);
    return ListView(
      padding: const EdgeInsets.only(bottom: 8),
      children: <Widget>[
        divider,
        _singleDrawerItem(Icons.dashboard, "Accueil", Routes.main, 1),
        divider,
        _singleDrawerItem(
            Icons.storage_rounded, "Articles", '/user/profile', 2),
        _singleDrawerItem(Icons.switch_access_shortcut, "Operations",
            '/user/notifications', 3),
        _singleDrawerItem(Icons.notifications_rounded, "Notifications",
            '/user/notifications', 4),
        _singleDrawerItem(
            Icons.store_rounded, "Mes boutiques", '/user/shops', 5),
        _singleDrawerItem(Icons.document_scanner_rounded, "Rapports", '', 6),
        divider,
        _singleDrawerItem(Icons.build_outlined, "Paramètres", '/setting', 7),
        _singleDrawerItem(
            Icons.help, "Aide & suggestions", '/help_feedback', 8),
        _singleDrawerItem(Icons.logout_rounded, "Déconnexion", '', 10),
      ],
    );
  }

  DrawerHeader buildDrawerHeader() {
    return DrawerHeader(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Get.theme.cardColor,
                ),
                child: const Icon(Icons.person, size: 80),
              ),
              const SizedBox(height: 8.0),
              Text("User name", style: Get.textTheme.titleLarge),
              Text(
                "user@email.com",
                style: TextStyle(
                  color: Get.theme.colorScheme.onSurface.withAlpha(150),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _singleDrawerItem(
      IconData iconData, String title, String destination, int position) {
    ThemeData theme = Get.theme;

    if (position == 10) {
      return ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        tileColor: theme.colorScheme.secondary.withAlpha(10),
        leading: Icon(iconData, size: 22, color: theme.colorScheme.secondary),
        title: Text(
          title,
          style: theme.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
            color: theme.colorScheme.secondary,
          ),
        ),
        onTap: () {},
      );
    }

    return ListTile(
      dense: true,
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
      onTap: () {
        Get.toNamed(destination);
        scaffoldKey.currentState!.closeDrawer();
      },
    );
  }
}