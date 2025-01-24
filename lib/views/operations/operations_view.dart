import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:stock_pro/controllers/operations/operations_controller.dart';
import 'package:stock_pro/utils/image_data.dart';
import 'package:stock_pro/widgets/drawer_widget.dart';
import 'package:stock_pro/widgets/list_tiles/operation_list_tile.dart';
import 'package:stock_pro/widgets/popup_menu_widget.dart';

class OperationsView extends GetView<OperationsController> {
  const OperationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OperationsController>(
      builder: (controller) {
        return Scaffold(
          key: controller.scaffoldKey,
          appBar: AppBar(
            title: Text('operations'.tr),
            leading: InkWell(
              onTap: controller.openDrawer,
              child: const Icon(Icons.menu_rounded),
            ),
            actions: [
              if (controller.loadingOperations)
                IconButton(
                  onPressed: () {},
                  icon: LoadingAnimationWidget.staggeredDotsWave(
                    color: Get.theme.colorScheme.onSurface,
                    size: 16,
                  ),
                ),
              if (controller.operations.isNotEmpty) ...[
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    PopupMenuWidget(
                      items: controller.sortOptions,
                      selectedItemIndex: controller.selectedOptionIndex,
                      onSelectedOptionChanged: controller.sortData,
                      icon: Icons.sort,
                    ),
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Text(
                            String.fromCharCode(controller.sortAscending
                                ? Icons.arrow_upward.codePoint
                                : Icons.arrow_downward.codePoint),
                            style: TextStyle(
                              inherit: false,
                              fontSize: 18,
                              color: Get.theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontFamily: controller.sortAscending
                                  ? Icons.arrow_upward.fontFamily
                                  : Icons.arrow_downward.fontFamily,
                            ),
                          )),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: controller.toggleSortOrder,
                  icon: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(
                        controller.sortAscending ? 0 : 3.14159),
                    child: const Icon(Icons.sort_by_alpha),
                  ),
                ),
                IconButton(
                  onPressed: controller.goToAddOperationView,
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ]
            ],
          ),
          drawerEnableOpenDragGesture: true,
          drawer: DrawerWidget(
            currentPage: controller.pagePosition,
            scaffoldKey: controller.scaffoldKey,
          ),
          body: controller.operations.isEmpty
              ? _buildEmptyWidget()
              : _buildOperationsList(),
        );
      },
    );
  }

  Widget _buildEmptyWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Get.isDarkMode
                ? ImageData.noOperationsDark
                : ImageData.noOperations,
          ),
          const SizedBox(
            height: 48,
          ),
          ElevatedButton(
            onPressed: controller.goToAddOperationView,
            child: Text("add_an_operation".tr),
          )
        ],
      ),
    );
  }

  ListView _buildOperationsList() {
    return ListView.separated(
      itemCount: controller.operations.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          onDismissed: (_) {
            controller.deleteOperation(controller.operations[index].id!);
          },
          confirmDismiss: (_) => controller.showDeleteDialog(),
          background: Container(
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete,
                    color: Get.theme.colorScheme.onError,
                  ),
                ),
              ],
            ),
          ),
          child: OperationListTile(
            operationModel: controller.operations[index],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: 1),
    );
  }
}
