import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:stock_pro/controllers/items/items_controller.dart';
import 'package:stock_pro/utils/image_data.dart';
import 'package:stock_pro/widgets/drawer_widget.dart';

class ItemsView extends GetView<ItemsController> {
  const ItemsView({super.key});

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
            actions: controller.selectedItems.isNotEmpty
                ? [
                    IconButton(
                      onPressed: null,
                      icon: Text("${controller.selectedItems.length}"),
                    ),
                    IconButton(
                      onPressed: controller.items.length ==
                              controller.selectedItems.length
                          ? controller.clearSelection
                          : controller.selectAllItems,
                      icon: Icon(
                        controller.items.length ==
                                controller.selectedItems.length
                            ? Icons.deselect
                            : Icons.select_all,
                      ),
                    ),
                    IconButton(
                      onPressed: controller.deleteSelectedItems,
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ]
                : [
                    if (controller.loadingItems)
                      IconButton(
                        onPressed: () {},
                        icon: LoadingAnimationWidget.staggeredDotsWave(
                          color: Get.theme.colorScheme.onSurface,
                          size: 16,
                        ),
                      ),
                    if (controller.items.isNotEmpty)
                      IconButton(
                        onPressed: controller.goToAddItemView,
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                  ],
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
    return ListView.separated(
      itemCount: controller.items.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(controller.items[index].name),
          subtitle: Text(
            controller.items[index].description,
            overflow: TextOverflow.ellipsis,
          ),
          leading: controller.selectedItems.contains(controller.items[index])
              ? CircleAvatar(
                  backgroundColor: Get.theme.colorScheme.primary,
                  child: Icon(
                    Icons.check,
                    color: Get.theme.colorScheme.onPrimary,
                  ),
                )
              : CircleAvatar(
                  child: Text(
                    controller.items[index].name[0].toUpperCase(),
                    style: Get.textTheme.bodyLarge,
                  ),
                ),
          onTap: () {
            if (controller.selectedItems.isEmpty) {
              controller.goToItemDetailsView(controller.items[index]);
            } else if (controller.selectedItems
                .contains(controller.items[index])) {
              controller.removeSelectedItem(controller.items[index]);
            } else {
              controller.selectItem(controller.items[index]);
            }
          },
          onLongPress: () {
            controller.selectItem(controller.items[index]);
          },
          trailing: Text(
            controller.items[index].quantity.toString(),
            style: Get.textTheme.bodyLarge,
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: 1),
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
            onPressed: controller.goToAddItemView,
            child: Text("add_your_first_item".tr),
          )
        ],
      ),
    );
  }
}
