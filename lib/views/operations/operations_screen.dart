import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/controllers/operations/operations_controller.dart';
import 'package:stock_pro/utils/image_data.dart';
import 'package:stock_pro/widgets/drawer_widget.dart';

class OperationsScreen extends GetView<OperationsController> {
  const OperationsScreen({super.key});

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
            actions: controller.operations.isNotEmpty
                ? [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_list),
                    ),
                    IconButton(
                      onPressed: controller.goToAddOperationScreen,
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ]
                : [],
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
            onPressed: controller.goToAddOperationScreen,
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
        return ListTile(
          title: Text(
              "${controller.operations[index].type.name.capitalize!} #${controller.operations[index].invoiceNumber}"),
          subtitle: Text(
            "${controller.operations[index].totalAmount} XAF",
            overflow: TextOverflow.ellipsis,
          ),
          leading: Container(
            width: 12,
            height: double.infinity,
            color: controller.operations[index].type.color,
          ),
          horizontalTitleGap: 8,
          trailing: controller.operations[index].transport != null
              ? const Icon(Icons.local_shipping_outlined)
              : null,
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: 1),
    );
  }
}
