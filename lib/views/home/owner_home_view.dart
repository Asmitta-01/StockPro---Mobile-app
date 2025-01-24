import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/controllers/home/owner_home_controller.dart';
import 'package:stock_pro/utils/extensions/number_extension.dart';
import 'package:stock_pro/utils/image_data.dart';
import 'package:stock_pro/widgets/drawer_widget.dart';
import 'package:stock_pro/widgets/getting_started_widget.dart';
import 'package:stock_pro/widgets/list_tiles/operation_list_tile.dart';

class OwnerHomeView extends GetView<OwnerHomeController> {
  const OwnerHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OwnerHomeController>(
      builder: (controller) {
        return Scaffold(
          key: controller.scaffoldKey,
          drawerEnableOpenDragGesture: true,
          drawer: DrawerWidget(
            currentPage: 1,
            scaffoldKey: controller.scaffoldKey,
          ),
          appBar: AppBar(
            shadowColor: Get.theme.colorScheme.onSurface.withAlpha(100),
            foregroundColor: Get.theme.colorScheme.onSurface.withAlpha(224),
            backgroundColor: Get.theme.colorScheme.surface,
            leading: InkWell(
              onTap: controller.openDrawer,
              child: const Icon(Icons.menu_rounded),
            ),
            title: Text("home".tr),
            // actions: const [
            //   Padding(
            //     padding: EdgeInsets.only(right: 16),
            //     child: InkWell(child: Icon(Icons.notifications_outlined)),
            //   )
            // ],
          ),
          body: controller.passedAll
              ? OwnerHomeWidget(ownerHomeController: controller)
              : GettingStartedWidget(controller: controller),
        );
      },
    );
  }
}

class OwnerHomeWidget extends StatelessWidget {
  const OwnerHomeWidget({
    super.key,
    required this.ownerHomeController,
  });

  final OwnerHomeController ownerHomeController;
  final spacing = const SizedBox(height: 20);
  final cardPadding = const EdgeInsets.all(12);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: [
        ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          children: [
            Text(
              "hello".tr,
              style: Get.textTheme.headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            spacing,
            _buildLatestOperationsCard(),
            spacing,
            _buildGainsCard(),
            spacing,
            Row(
              children: [
                Flexible(child: _buildTotalOperationsCard()),
                const SizedBox(width: 12),
                Flexible(child: _buildTotalItemsCard())
              ],
            ),
          ],
        ),
        spacing,
      ],
    );
  }

  Card _buildTotalOperationsCard() {
    return Card(
      color: Get.theme.cardColor,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: cardPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Get.isDarkMode ? ImageData.walletDark : ImageData.wallet,
              height: 70,
            ),
            const SizedBox(height: 6),
            Text(
              ownerHomeController.dailyOperations.toString(),
              style: Get.textTheme.headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              "operations_made_on_this_day".tr,
              textAlign: TextAlign.center,
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: ownerHomeController.goToAddOperationView,
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 12)),
                    child: Text("add_an_operation".tr),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Card _buildTotalItemsCard() {
    return Card(
      color: Get.theme.cardColor,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: cardPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageData.items, height: 70),
            const SizedBox(height: 6),
            Text(
              ownerHomeController.totalItems.toString(),
              style: Get.textTheme.headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              "total_items_present_in_your_shop".tr,
              textAlign: TextAlign.center,
            ),
            OutlinedButton(
              onPressed: ownerHomeController.goToAddOperationView,
              style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 8)),
              child: Text(
                "add_an_item".tr,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGainsCard() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Card(
          color: Get.theme.colorScheme.primary,
          margin: EdgeInsets.only(left: Get.size.width * .1),
          child: Padding(
            padding: cardPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox.shrink(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "you_have_a_recipe".tr,
                      style: TextStyle(color: Get.theme.colorScheme.onPrimary),
                    ),
                    Text(
                      ownerHomeController.dailyIncomes < 1e6
                          ? ownerHomeController.dailyIncomes.toSimpleCurrency
                          : ownerHomeController.dailyIncomes.toCurrency,
                      style: Get.textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Get.theme.colorScheme.onPrimary),
                    ),
                    Text(
                      "today".tr.toLowerCase(),
                      style: TextStyle(color: Get.theme.colorScheme.onPrimary),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          child: Image.asset(
            ImageData.sellWindow,
            width: Get.size.width * .38,
          ),
        )
      ],
    );
  }

  Widget _buildLatestOperationsCard() {
    return Container(
      padding: cardPadding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              blurRadius: 5,
              color: Get.theme.colorScheme.onSurface.withOpacity(.4))
        ],
        color: Get.theme.scaffoldBackgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "latest_operations".tr,
                style: Get.textTheme.titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Image.asset(
                Get.isDarkMode ? ImageData.calendarDark : ImageData.calendar,
                height: 30,
              ),
            ],
          ),
          ownerHomeController.latestOperations.isEmpty
              ? const SizedBox.shrink()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: ownerHomeController.latestOperations.length,
                  itemBuilder: (context, index) {
                    return OperationListTile(
                      operationModel:
                          ownerHomeController.latestOperations[index],
                    );
                  },
                ),
          Text(
            "x_latest_operations_made"
                .trParams({'x': ownerHomeController.limit.toString()}),
            style: TextStyle(
              color: Get.theme.colorScheme.onSurface.withOpacity(.5),
            ),
          ),
        ],
      ),
    );
  }
}
