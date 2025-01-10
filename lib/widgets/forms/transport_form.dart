import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/models/enums/transport_method.dart';

class TransportForm extends StatefulWidget {
  const TransportForm(
      {super.key,
      required this.costController,
      required this.methodController});

  final TextEditingController costController;
  final TextEditingController methodController;

  @override
  State<TransportForm> createState() => _TransportFormState();
}

class _TransportFormState extends State<TransportForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("choose_the_method_used".tr),
        const SizedBox(height: 8),
        DropdownButtonFormField(
          dropdownColor: Get.theme.scaffoldBackgroundColor,
          value: TransportMethod.values.firstWhereOrNull(
              (method) => method.name == widget.methodController.text),
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: 'transport_method'.tr,
          ),
          items: TransportMethod.values
              .map((method) => DropdownMenuItem(
                    value: method,
                    child: Text(method.name.capitalize!),
                  ))
              .toList(),
          onChanged: (method) {
            setState(() {
              widget.methodController.text = method!.name;
            });
          },
          isDense: true,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: widget.costController,
          keyboardType: const TextInputType.numberWithOptions(),
          decoration: InputDecoration(
            labelText: 'transport_cost'.tr,
            helperText: "leave_blank_if_the_amount_has_not_been_defined".tr,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
      ],
    ));
  }
}
