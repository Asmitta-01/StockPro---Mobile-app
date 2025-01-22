import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stock_pro/models/operation_model.dart';
import 'package:stock_pro/utils/extensions/number_extension.dart';

class OperationBottomSheet extends StatefulWidget {
  final OperationModel operation;

  const OperationBottomSheet({
    super.key,
    required this.operation,
  });

  @override
  State<OperationBottomSheet> createState() => _OperationBottomSheetState();
}

class _OperationBottomSheetState extends State<OperationBottomSheet> {
  bool showUnitPrices = false;

  void toggleShowUniPrices() {
    setState(() {
      showUnitPrices = !showUnitPrices;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              widget.operation.type.icon(),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "#${widget.operation.invoiceNumber}",
                      style: Get.textTheme.titleLarge,
                    ),
                    Text(
                      "Total: ${widget.operation.totalAmount.toSimpleCurrency}",
                      style: Get.textTheme.headlineSmall!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${'details'.tr}: ", style: Get.textTheme.bodyLarge),
              TextButton(
                onPressed: toggleShowUniPrices,
                style: TextButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                ),
                child: Text(showUnitPrices ? "hide".tr : "show_unit_prices".tr),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Text("qty".tr)],
          ),
          buildItemsList(),
          const Divider(),
          buildTotalsWidget(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${'made_on'.tr}: ${DateFormat('MMMM d, y', Get.locale?.languageCode).format(widget.operation.createdAt).capitalize}',
                style: Get.textTheme.bodySmall!.copyWith(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildItemsList() {
    return ListView.builder(
      itemCount: widget.operation.items.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final item = widget.operation.items.entries.elementAt(index);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.key.name),
                if (showUnitPrices)
                  Text(
                    item.key.price.toSimpleCurrency,
                    style: const TextStyle(color: Colors.grey),
                  )
              ],
            ),
            Text(item.value.toString()),
          ],
        );
      },
    );
  }

  Widget buildTotalsWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("sub_total".tr),
            Text(widget.operation.amount.toSimpleCurrency),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("transport".tr),
                const SizedBox(width: 4),
                if (widget.operation.transport != null)
                  Tooltip(
                    message:
                        "${"transport_method".tr}: ${widget.operation.transport?.method.name.capitalize}",
                    decoration:
                        BoxDecoration(color: Get.theme.colorScheme.onSurface),
                    triggerMode: TooltipTriggerMode.tap,
                    child: const Icon(
                      Icons.lightbulb_circle_outlined,
                      size: 16,
                    ),
                  ),
              ],
            ),
            Text((widget.operation.transport?.cost ?? 0).toSimpleCurrency),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "total".tr,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(
              widget.operation.totalAmount.toSimpleCurrency,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}
