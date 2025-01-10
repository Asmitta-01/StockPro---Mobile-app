import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:stock_pro/models/item_model.dart';

class AddItemInOperationWidget extends StatelessWidget {
  const AddItemInOperationWidget({
    super.key,
    required this.items,
    this.onSelected,
  });

  final List<ItemModel> items;
  final Function(ItemModel)? onSelected;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => Get.bottomSheet(buildSheet()),
      style: const ButtonStyle(
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
        visualDensity: VisualDensity.compact,
      ),
      label: Text("add_an_item".tr),
      icon: const Icon(Icons.add),
    );
  }

  Widget buildSheet() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'search_the_item_to_add'.tr,
            style: Get.textTheme.titleMedium!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          TypeAheadField<ItemModel>(
            itemBuilder: (context, model) {
              return ListTile(
                tileColor: Get.theme.scaffoldBackgroundColor,
                title: Text(model.name),
                visualDensity: VisualDensity.compact,
                subtitle: Text(
                  model.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
            onSelected: onSelected,
            itemSeparatorBuilder: (context, index) => const Divider(height: 1),
            suggestionsCallback: (search) => items
                .where((model) =>
                    model.name.toLowerCase().contains(search.toLowerCase()))
                .toList(),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text("tap_in_the_field_to_show_suggestions".tr),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_upward_rounded,
                size: 16,
                color: Get.theme.colorScheme.onSurface,
              )
            ],
          ),
        ],
      ),
    );
  }
}
