import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:stock_pro/controllers/operations/add_operation_controller.dart';
import 'package:stock_pro/widgets/forms/operation_form.dart';

class AddOperationView extends GetView<AddOperationController> {
  const AddOperationView({super.key});

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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shrinkWrap: true,
            children: [
              Text('please_fill_the_following_form'.tr),
              const SizedBox(height: 18.0),
              OperationForm(
                formKey: controller.formKey,
                invoiceController: controller.invoiceController,
                amountController: controller.amountController,
                commentController: controller.commentController,
                dateController: controller.dateController,
                typeController: controller.typeController,
                transportCostController: controller.transportCostController,
                transportTypeController: controller.transportTypeController,
              ),
            ],
          ),
        );
      },
    );
  }
}
