import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stock_pro/controllers/reports/stock_reports_controller.dart';
import 'package:stock_pro/utils/extensions/number_extension.dart';
import 'package:stock_pro/utils/image_data.dart';
import 'package:stock_pro/widgets/pick_item_widget.dart';

class StockReportsView extends GetView<StockReportsController> {
  const StockReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StockReportsController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('stock_reports'.tr),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share),
              ),
            ],
          ),
          body: Container(
            color: Get.theme.colorScheme.onSurface.withOpacity(.05),
            height: Get.size.height,
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: [
                _buildStockStatsGrid(),
                const SizedBox(height: 16),
                _buildItemsReportCard(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildItemsReportCard() {
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
                      "items".tr,
                      style: Get.textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text("data".tr),
                  ],
                ),
                PickItemWidget(
                  items: controller.items,
                  buttonLabel: controller.selectedItem?.name ?? "all".tr,
                  buttonIcon: Icons.arrow_drop_down,
                  onSelected: controller.selectItem,
                  isChip: true,
                )
              ],
            ),
            const Divider(height: 24),
            _buildDataRow("in_stock".tr,
                "${controller.selectedItem?.quantity ?? controller.totalItemsQuantity}"),
            _buildDataRow(
                "last_supply".tr,
                DateFormat('d MMMM yyy', Get.locale?.languageCode).format(
                    controller.selectedItem?.createdAt ?? DateTime.now())),
            if (controller.selectedItem != null)
              _buildDataRow(
                  "unit_price".tr, "${controller.selectedItem?.price} XAF"),
            _buildDataRow(
              "estimated_value".tr,
              controller.selectedItem?.estimatedStockValue.toCurrency ??
                  controller.totalItemsPrice.toCurrency,
            ),
            _buildDataRow("output_frequency".tr,
                "${controller.selectedItem?.quantity ?? 0 / 10} / jr"),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: Get.textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.normal), 
            softWrap: true,
          ),
        ),
        Text(value, style: Get.textTheme.bodyLarge),
      ],
    );
  }

  Widget _buildStockStatsGrid() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: Get.size.height < 700 ? 1 : 1.1,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      physics: const ScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: [
        _buildStatCard(
          title: 'total_items'.tr,
          value: '${controller.items.length}',
          image: Image.asset(
            ImageData.items,
            height: 60,
            fit: BoxFit.cover,
            // color: color,
          ),
        ),
        _buildStatCard(
          title: 'low_stock'.tr,
          value:
              '${controller.items.where((item) => item.quantity < 10).length}',
          image: Image.asset(
            ImageData.itemsAlert,
            height: 60,
            fit: BoxFit.cover,
            // color: color,
          ),
          color: Get.theme.colorScheme.secondary,
        ),
        _buildStatCard(
          title: 'out_of_stock'.tr,
          value:
              '${controller.items.where((item) => item.quantity == 0).length}',
          image: Image.asset(
            ImageData.itemsOutOfStock,
            height: 60,
            fit: BoxFit.cover,
            // color: color,
          ),
          color: Colors.red,
        ),
        _buildStatCard(
          title: 'estimated_value'.tr,
          value: controller.totalItemsPrice.toCurrency,
          image: Image.asset(
            Get.isDarkMode ? ImageData.walletDark : ImageData.wallet,
            height: 60,
            fit: BoxFit.cover,
          ),
          color: Get.theme.colorScheme.primary,
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required Image image,
    Color? color,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image,
            Text(title, textAlign: TextAlign.center),
            const SizedBox(height: 4),
            Text(
              value,
              style: Get.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
