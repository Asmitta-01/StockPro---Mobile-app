import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/controllers/home/owner_home_controller.dart';

class GettingStartedWidget extends StatelessWidget {
  const GettingStartedWidget({
    super.key,
    required this.controller,
  });

  final OwnerHomeController controller;

  @override
  Widget build(BuildContext context) {
    var doneIcon = Icon(
      Icons.check_circle,
      color: Get.theme.colorScheme.primary,
    );

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      children: [
        Text("getting_started".tr, style: Get.textTheme.headlineSmall),
        const SizedBox(height: 18),
        Text("explore_all_the_possibilities_offered_by_our_app".tr),
        const SizedBox(height: 18),
        ListTile(
          trailing: controller.addedItem
              ? doneIcon
              : const Icon(Icons.chevron_right_rounded),
          onTap: controller.goToAddItemView,
          title: Text("add_your_first_item".tr),
          leading: const Icon(Icons.add_circle_outline),
          contentPadding: EdgeInsets.zero,
        ),
        ListTile(
          trailing: controller.madeFirstOperation
              ? doneIcon
              : const Icon(Icons.chevron_right_rounded),
          onTap: controller.goToAddOperationView,
          title: Text("record_your_first_operation".tr),
          leading: const Icon(Icons.sell_outlined),
          contentPadding: EdgeInsets.zero,
        ),
        ListTile(
          trailing: controller.definedStockAlert
              ? doneIcon
              : const Icon(Icons.chevron_right_rounded),
          onTap: controller.goToDefineAlertView,
          title: Text("define_the_stock_alert_threshold_of_an_item".tr),
          leading: const Icon(Icons.add_alert_outlined),
          contentPadding: EdgeInsets.zero,
        ),
        ListTile(
          trailing: controller.addedManager
              ? doneIcon
              : const Icon(Icons.chevron_right_rounded),
          onTap: controller.goToAddManagerView,
          title: Text("add_a_manager".tr),
          leading: const Icon(Icons.manage_accounts_outlined),
          contentPadding: EdgeInsets.zero,
        ),
        const SizedBox(height: 28),
        ElevatedButton(
          onPressed: controller.passedAllSteps()
              ? controller.closeGettingStarted
              : null,
          style: ElevatedButton.styleFrom(
            side: controller.passedAllSteps() ? null : const BorderSide(),
          ),
          child: Text("done".tr),
        )
      ],
    );
  }
}
