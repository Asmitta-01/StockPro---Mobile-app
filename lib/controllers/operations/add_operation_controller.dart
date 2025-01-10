import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/models/enums/operation_type.dart';
import 'package:stock_pro/models/enums/transport_method.dart';
import 'package:stock_pro/models/operation_model.dart';
import 'package:stock_pro/models/transport_model.dart';
import 'package:stock_pro/widgets/ongoing_request_dialog.dart';

class AddOperationController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final invoiceController = TextEditingController();
  final amountController = TextEditingController();
  final commentController = TextEditingController();
  final dateController =
      TextEditingController(text: DateTime.now().toString().split(" ")[0]);
  final typeController = TextEditingController();
  final transportCostController = TextEditingController();
  final transportTypeController = TextEditingController();

  bool savingOperation = false;

  void addOperation() async {
    if (formKey.currentState!.validate()) {
      Get.dialog(
        PopScope(
          canPop: false,
          child: OngoingRequestDialog(text: 'saving_operation'.tr),
        ),
        barrierDismissible: false,
        name: "Dialog - ${'saving_operation'.tr}",
      );

      savingOperation = true;
      update();

      OperationModel operation = OperationModel(
        invoiceNumber: invoiceController.text,
        amount: double.parse(amountController.text),
        comment: commentController.text,
        createdAt: DateTime.parse(dateController.text),
        type: OperationType.fromString(typeController.text),
        id: 0,
        transport: TransportModel(
          TransportMethod.fromString(transportTypeController.text),
          double.tryParse(transportCostController.text) ?? 0.0,
        ),
      );
      debugPrint(operation.toString());

      Future.delayed(const Duration(seconds: 3), () {
        savingOperation = false;
        update();

        Get.back(closeOverlays: true);
        Get.showSnackbar(GetSnackBar(
          message: "operation_saved".tr,
          icon: Icon(
            Icons.check_circle_outline,
            color: Get.theme.colorScheme.onPrimary,
          ),
          backgroundColor: Get.theme.colorScheme.primary,
          duration: const Duration(seconds: 3),
          onTap: (snack) => Get.closeCurrentSnackbar(),
        ));
      });
    }
  }
}
