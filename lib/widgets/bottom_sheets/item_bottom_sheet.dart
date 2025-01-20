import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stock_pro/models/item_model.dart';
import 'package:stock_pro/utils/extensions/number_extension.dart';

class ItemBottomSheet extends StatelessWidget {
  final ItemModel item;
  final void Function()? onUpdateThreshold;

  const ItemBottomSheet({
    super.key,
    required this.item,
    this.onUpdateThreshold,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (item.image != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    item.image!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: Get.textTheme.titleLarge),
                    Text(
                      item.price.toSimpleCurrency,
                      style: Get.textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text("${'description'.tr}: ", style: Get.textTheme.bodyLarge),
          const SizedBox(height: 8),
          Text(item.description),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${'quantity_in_stock'.tr}: ${item.quantity}',
                    style: TextStyle(
                      color: item.quantity <= item.stockThreshold
                          ? Colors.red
                          : Get.theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: item.quantity <= item.stockThreshold
                          ? Get.theme.colorScheme.error.withOpacity(0.1)
                          : Get.theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Text('${'stock_threshold'.tr}: ${item.stockThreshold}'),
                        const SizedBox(width: 8),
                        if (onUpdateThreshold != null)
                          InkWell(
                            onTap: onUpdateThreshold,
                            child: Text(
                              'update'.tr,
                              style: TextStyle(
                                color: Get.theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Text(
                  '${'added'.tr}: ${DateFormat('MMMM d, y', Get.locale?.languageCode).format(item.createdAt)}',
                  style: Get.textTheme.bodySmall!.copyWith(
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
