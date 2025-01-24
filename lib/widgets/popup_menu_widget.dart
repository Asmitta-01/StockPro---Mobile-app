import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopupMenuWidget extends StatelessWidget {
  const PopupMenuWidget({
    super.key,
    required this.items,
    required this.selectedItemIndex,
    required this.onSelectedOptionChanged,
    this.iconSize,
    this.icon = Icons.filter_list,
  });

  final double? iconSize;
  final IconData? icon;
  final int selectedItemIndex;
  final List<String> items;
  final Function(int) onSelectedOptionChanged;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        icon,
        size: iconSize,
      ),
      color: Get.theme.colorScheme.surface,
      initialValue: selectedItemIndex,
      onSelected: onSelectedOptionChanged,
      itemBuilder: (context) {
        return items
            .asMap()
            .entries
            .map(
              (entry) => PopupMenuItem(
                value: entry.key,
                child: Text(entry.value),
              ),
            )
            .toList();
      },
    );
  }
}
