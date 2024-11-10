import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/controllers/home/owner_home_controller.dart';
import 'package:stock_pro/utils/image_data.dart';
import 'package:stock_pro/widgets/getting_started_widget.dart';

class OwnerHomeScreen extends GetView<OwnerHomeController> {
  const OwnerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OwnerHomeController>(
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
              "${"hello".tr}, Paul",
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: Get.theme.colorScheme.primary,
          child: _getPremiumCard(),
        ),
      ],
    );
  }

  Card _getPremiumCard() {
    const spacing_ = SizedBox(height: 6);
    return Card(
      child: Container(
        padding: cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(ImageData.logo, width: 120),
            spacing_,
            Text(
              "you_are_good_with_premium".tr,
              style: Get.textTheme.titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            spacing_,
            Text("premium_pass_intro_text".tr),
            spacing_,
            ElevatedButton.icon(
              onPressed: ownerHomeController.getPremium,
              label: Text("get_premium_pass".tr),
              icon: const Icon(Icons.diamond),
            ),
          ],
        ),
      ),
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
            Image.asset(ImageData.google),
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
                    onPressed: ownerHomeController.goToAddOperationScreen,
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
            Image.asset(ImageData.google),
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
              onPressed: ownerHomeController.goToAddOperationScreen,
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

  Card _buildGainsCard() {
    return Card(
      color: Get.theme.colorScheme.primary,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: cardPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox.shrink(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "you_have_gained".tr,
                  style: TextStyle(color: Get.theme.colorScheme.onPrimary),
                ),
                Text(
                  "100 000 XAF",
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
              const Icon(Icons.local_activity_outlined),
            ],
          ),
          const SizedBox(height: 36),
          Text(
            "x_latest_operations_made".trParams({'x': "02"}),
            style: TextStyle(
              color: Get.theme.colorScheme.onSurface.withOpacity(.5),
            ),
          ),
        ],
      ),
    );
  }
}
