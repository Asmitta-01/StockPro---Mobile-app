import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/models/item_model.dart';
import 'package:stock_pro/routes.dart';
import 'package:stock_pro/widgets/bottom_sheets/item_bottom_sheet.dart';

class ItemListTile extends StatelessWidget {
  const ItemListTile({
    super.key,
    required this.item,
    this.onTap,
    this.onLongPress,
    required this.isSelected,
    this.onUpdateThreshold,
    this.onEditItem,
  });

  final ItemModel item;
  final bool isSelected;
  final Function()? onTap;
  final Function()? onLongPress;
  final Function(ItemModel, int)? onUpdateThreshold;
  final Function(ItemModel)? onEditItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
      subtitle: Text(
        item.description,
        overflow: TextOverflow.ellipsis,
      ),
      leading: isSelected
          ? CircleAvatar(
              backgroundColor: Get.theme.colorScheme.primary,
              child: Icon(
                Icons.check,
                color: Get.theme.colorScheme.onPrimary,
              ),
            )
          : CircleAvatar(
              child: Text(
                item.name[0].toUpperCase(),
                style: Get.textTheme.bodyLarge,
              ),
            ),
      onTap: _onTap,
      onLongPress: onLongPress,
      trailing: Text(
        item.quantity.toString(),
        style: Get.textTheme.bodyLarge,
      ),
    );
  }

  void _onTap() {
    if (onTap != null) {
      onTap!();
      return;
    }

    Get.bottomSheet(
      ItemBottomSheet(
        item: item,
        onUpdateThreshold: onUpdateThreshold,
        onEditItem: onEditItem,
      ),
      isScrollControlled: true,
      settings: RouteSettings(
          name: Routes.singleItem.replaceFirst(':id', "${item.id}")),
    );
  }
}
