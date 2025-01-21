import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:stock_pro/controllers/items/edit_item_controller.dart';
import 'package:stock_pro/widgets/forms/item_form.dart';

class EditItemView extends GetView<EditItemController> {
  const EditItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditItemController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('edit_item'.tr),
            actions: [
              IconButton(
                onPressed:
                    controller.updatingItem ? null : controller.updateItem,
                icon: controller.updatingItem
                    ? LoadingAnimationWidget.staggeredDotsWave(
                        color: Get.theme.colorScheme.onSurface, size: 16)
                    : const Icon(Icons.save_outlined),
              ),
            ],
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              shrinkWrap: true,
              children: [
                Text('change_your_item_information_with_ease'.tr),
                const SizedBox(height: 16.0),
                ItemForm(
                  formKey: controller.formKey,
                  nameController: controller.nameController,
                  priceController: controller.priceController,
                  descriptionController: controller.descriptionController,
                  quantityController: controller.quantityController,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
