import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/controllers/reports/reports_controller.dart';
import 'package:stock_pro/widgets/charts/bar_chart.dart';
import 'package:stock_pro/widgets/charts/line_chart.dart';
import 'package:stock_pro/widgets/charts/pie_chart.dart';
import 'package:stock_pro/widgets/drawer_widget.dart';

class ReportsView extends GetView<ReportsController> {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportsController>(
      builder: (controller) {
        return Scaffold(
          key: controller.scaffoldKey,
          appBar: AppBar(
            title: Text('reports'.tr),
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
          body: ListView(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            children: [
              Text("visualize_your_activity_with_our_personalized_reports".tr),
              const SizedBox(height: 8),
              getGoToStockCard(),
              const SizedBox(height: 8),
              buildLatestOutOperations(),
              const SizedBox(height: 12),
              buildLatestIncomes(),
              const SizedBox(height: 12),
              buildIncomesDelta(),
              const SizedBox(height: 12),
              buildRecentItems(),
            ],
          ),
        );
      },
    );
  }

  Card getGoToStockCard() {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: controller.goToStockReportsView,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "check_stock_reports".tr,
                      style: Get.textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text("checkout_statistics_on_your_stock_movements".tr),
                  ],
                ),
              ),
              const Icon(Icons.keyboard_arrow_right),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLatestOutOperations() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "outgoing_operations".tr,
                      style: Get.textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text("last_x_days".trParams({'x': '7'})),
                  ],
                ),
                const Icon(Icons.keyboard_arrow_right),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${controller.data1Average.toInt()}k",
                      style: Get.textTheme.headlineLarge!.copyWith(
                        color: Get.theme.colorScheme.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "average".tr,
                      style: TextStyle(color: Get.theme.colorScheme.secondary),
                    ),
                  ],
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: BarChartWidget(
                    barData: controller.barData1,
                    barColor: Get.theme.colorScheme.secondary,
                    labels: controller.barLabels,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLatestIncomes() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "incoming_operations".tr,
                      style: Get.textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text("last_x_days".trParams({'x': '7'})),
                  ],
                ),
                const Icon(Icons.keyboard_arrow_right),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${controller.data2Average.toInt()}k",
                      style: Get.textTheme.headlineLarge!.copyWith(
                        color: Get.theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "average".tr,
                      style: TextStyle(color: Get.theme.colorScheme.primary),
                    ),
                  ],
                ),
                const SizedBox(width: 24),
                Expanded(
                    child: BarChartWidget(
                  barColor: Get.theme.colorScheme.primary,
                  barData: controller.barData2,
                  labels: controller.barLabels,
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIncomesDelta() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "operations_amounts".tr,
              style: Get.textTheme.titleMedium!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            Text("vs_estimated_amounts".tr),
            const SizedBox(height: 16),
            const LineChartWidget(),
          ],
        ),
      ),
    );
  }

  Widget buildRecentItems() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "best_selling_items".tr,
              style: Get.textTheme.titleMedium!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            Text("last_x_days".trParams({'x': '7'})),
            PieChartWidget(
              colors: controller.pieColors,
              values: controller.pieData,
              labels: controller.pieLabels,
            ),
          ],
        ),
      ),
    );
  }
}
