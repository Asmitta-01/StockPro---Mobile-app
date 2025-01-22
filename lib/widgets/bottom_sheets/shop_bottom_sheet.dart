import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/models/shop_model.dart';

class ShopBottomSheet extends StatefulWidget {
  const ShopBottomSheet(
      {super.key, required this.shopModel, this.onTapActive, this.onEdit});

  final ShopModel shopModel;
  final void Function()? onTapActive;
  final void Function()? onEdit;

  @override
  State<StatefulWidget> createState() => ShopBottomSheetState();
}

class ShopBottomSheetState extends State<ShopBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.shopModel.image != null)
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                      image: NetworkImage(widget.shopModel.image!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

              // Shop info
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.shopModel.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (widget.shopModel.active)
                          Chip(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Get.theme.colorScheme.primary),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.all(2),
                            label: Text(
                              "active".tr,
                              style: Get.textTheme.bodyMedium!.copyWith(
                                  color: Get.theme.colorScheme.onPrimary),
                            ),
                            backgroundColor: Get.theme.colorScheme.primary,
                          )
                      ],
                    ),
                    buildShopAddress(),
                    const SizedBox(height: 8),
                    buildCategories(),
                    const SizedBox(height: 24),
                    buildActionButtons(),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: -24 * 2,
            child: getShopIcon(),
          ),
        ],
      ),
    );
  }

  Row buildShopAddress() {
    return Row(
      children: [
        const Icon(Icons.location_on_outlined, size: 18),
        const SizedBox(width: 4),
        Text(widget.shopModel.address),
        const SizedBox(width: 8),
        if (widget.shopModel.website != null) ...[
          const Icon(Icons.language, size: 18),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              widget.shopModel.website!,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ],
    );
  }

  Widget getShopIcon() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.primary,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Get.theme.colorScheme.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        Icons.store,
        color: Get.theme.colorScheme.onPrimary,
        size: 32,
      ),
    );
  }

  Row buildActionButtons() {
    return Row(
      children: [
        if (widget.onEdit != null)
          OutlinedButton.icon(
            onPressed: widget.onEdit,
            style: OutlinedButton.styleFrom(
              backgroundColor: Get.theme.colorScheme.primary.withOpacity(.2),
              foregroundColor: Get.theme.colorScheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Get.theme.colorScheme.primary),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            label: Text('edit_shop'.tr),
            icon: const Icon(Icons.edit),
            iconAlignment: IconAlignment.end,
          ),
        const SizedBox(width: 16),
        if (!widget.shopModel.active)
          Expanded(
            child: ElevatedButton(
              onPressed: widget.onTapActive,
              child: Text(
                'set_as_active'.tr,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
      ],
    );
  }

  Wrap buildCategories() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: widget.shopModel.categories
          .map((category) => Chip(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Get.theme.colorScheme.primary),
                  borderRadius: BorderRadius.circular(16),
                ),
                label: Text(
                  category,
                  style: Get.textTheme.bodySmall,
                ),
                backgroundColor: Get.theme.colorScheme.primary.withOpacity(.1),
              ))
          .toList(),
    );
  }
}
