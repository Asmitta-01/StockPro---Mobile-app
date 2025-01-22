import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/models/operation_model.dart';
import 'package:stock_pro/widgets/bottom_sheets/operation_bottom_sheet.dart';

class OperationListTile extends StatelessWidget {
  const OperationListTile({
    super.key,
    required this.operationModel,
  });

  final OperationModel operationModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          "${operationModel.type.name.capitalize!} #${operationModel.invoiceNumber}"),
      subtitle: Text(
        "${operationModel.totalAmount} XAF",
        overflow: TextOverflow.ellipsis,
      ),
      leading: Container(
        width: 12,
        height: double.infinity,
        color: operationModel.type.color,
      ),
      horizontalTitleGap: 8,
      trailing: operationModel.transport != null
          ? const Icon(Icons.local_shipping_outlined)
          : null,
      onTap: () {
        Get.bottomSheet(
          OperationBottomSheet(
            operation: operationModel,
          ),
          isScrollControlled: true,
        );
      },
    );
  }
}
