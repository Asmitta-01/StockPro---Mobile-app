import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController descriptionController;
  final TextEditingController quantityController;

  const ItemForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.priceController,
    required this.descriptionController,
    required this.quantityController,
  });

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final buttonStyle = ButtonStyle(
    minimumSize: WidgetStateProperty.all(Size.zero),
    padding: WidgetStateProperty.all(EdgeInsets.zero),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    visualDensity: VisualDensity.compact,
    backgroundColor: WidgetStateProperty.resolveWith(
      (states) {
        if (states.contains(WidgetState.disabled)) {
          return Get.theme.colorScheme.onSurface.withOpacity(.1);
        }
        return Get.theme.colorScheme.primary;
      },
    ),
    iconColor: WidgetStatePropertyAll(Get.theme.colorScheme.onPrimary),
  );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: widget.nameController,
            decoration: InputDecoration(
              labelText: 'item_name'.tr,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'please_enter_item_name'.tr;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: widget.priceController,
            decoration: InputDecoration(
              labelText: 'item_price'.tr,
              prefixIcon: const IconButton(onPressed: null, icon: Text('XAF')),
              isDense: true,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'please_enter_item_price'.tr;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: widget.descriptionController,
            decoration: InputDecoration(
              labelText: 'description'.tr,
              hintText: "item_description".tr,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            maxLines: 3,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter description';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: widget.quantityController,
            decoration: InputDecoration(
              labelText: 'item_quantity'.tr,
              hintText: '0',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                      onPressed: () {
                        int quantity =
                            int.tryParse(widget.quantityController.text) ?? 0;
                        widget.quantityController.text =
                            (quantity + 1).toString();
                      },
                      style: buttonStyle,
                      icon: const Icon(Icons.add),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                      onPressed: () {
                        int quantity =
                            int.tryParse(widget.quantityController.text) ?? 0;
                        if (quantity > 0) {
                          widget.quantityController.text =
                              (quantity - 1).toString();
                        }
                      },
                      style: buttonStyle,
                      icon: const Icon(Icons.remove),
                    ),
                  ),
                ],
              ),
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'please_enter_item_quantity'.tr;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
