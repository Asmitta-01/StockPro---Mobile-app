import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:stock_pro/controllers/operations/add_operation_controller.dart';

class AddOperationScreen extends GetView<AddOperationController> {
  const AddOperationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddOperationController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('add_an_operation'.tr),
            actions: [
              IconButton(
                onPressed:
                    controller.savingOperation ? null : controller.addOperation,
                icon: controller.savingOperation
                    ? LoadingAnimationWidget.staggeredDotsWave(
                        color: Get.theme.colorScheme.onSurface, size: 16)
                    : const Icon(Icons.save_outlined),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16.0),
            shrinkWrap: true,
            children: [],
          ),
        );
      },
    );
  }
}
