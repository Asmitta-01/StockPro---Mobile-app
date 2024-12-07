import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/controllers/items/items_controller.dart';
import 'package:stock_pro/utils/image_data.dart';
import 'package:stock_pro/widgets/drawer_widget.dart';

class ItemsScreen extends GetView<ItemsController> {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ItemsController>(
      builder: (controller) {
        return Scaffold(
          key: controller.scaffoldKey,
          appBar: AppBar(
            title: Text('items'.tr),
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
          body: controller.items.isNotEmpty
              ? _buildItemsList(controller)
              : _buildEmptyWidget(),
        );
      },
    );
  }

  ListView _buildItemsList(ItemsController controller) {
    return ListView.builder(
      itemCount: controller.items.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(controller.items[index].name),
          subtitle: Text(controller.items[index].description),
          trailing: Text(controller.items[index].price.toString()),
        );
      },
    );
  }

  Widget _buildEmptyWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
              Get.isDarkMode ? ImageData.noItemsDark : ImageData.noItems),
          ElevatedButton(
            onPressed: controller.goToAddItemScreen,
            child: Text("add_your_first_item".tr),
          )
        ],
      ),
    );
  }
}
