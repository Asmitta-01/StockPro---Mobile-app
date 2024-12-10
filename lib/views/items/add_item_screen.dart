import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:stock_pro/controllers/items/add_item_controller.dart';
import 'package:stock_pro/widgets/forms/item_form.dart';

class AddItemScreen extends GetView<AddItemController> {
  const AddItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddItemController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('add_an_item'.tr),
            actions: [
              IconButton(
                onPressed: controller.savingItem ? null : controller.addItem,
                icon: controller.savingItem
                    ? LoadingAnimationWidget.staggeredDotsWave(
                        color: Get.theme.colorScheme.onSurface, size: 16)
                    : const Icon(Icons.save_outlined),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16.0),
            shrinkWrap: true,
            children: [
              Text('please_fill_in_the_item_details_below'.tr),
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
        );
      },
    );
  }
}
