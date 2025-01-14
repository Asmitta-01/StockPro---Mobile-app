import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/models/enums/operation_type.dart';
import 'package:stock_pro/models/item_model.dart';
import 'package:stock_pro/widgets/pick_item_widget.dart';
import 'package:stock_pro/widgets/forms/transport_form.dart';

class OperationForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController invoiceController;
  final TextEditingController amountController;
  final TextEditingController commentController;
  final TextEditingController dateController;
  final TextEditingController typeController;
  final TextEditingController transportCostController;
  final TextEditingController transportTypeController;

  const OperationForm({
    super.key,
    required this.formKey,
    required this.invoiceController,
    required this.amountController,
    required this.commentController,
    required this.dateController,
    required this.typeController,
    required this.transportCostController,
    required this.transportTypeController,
  });

  @override
  State<OperationForm> createState() => _OperationFormState();
}

class _OperationFormState extends State<OperationForm> {
  final buttonStyle = ButtonStyle(
    minimumSize: WidgetStateProperty.all(Size.zero),
    padding: WidgetStateProperty.all(EdgeInsets.zero),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    visualDensity: VisualDensity.compact,
    backgroundColor: WidgetStatePropertyAll(Get.theme.colorScheme.onPrimary),
    iconColor: WidgetStateProperty.resolveWith(
      (states) {
        if (states.contains(WidgetState.disabled)) {
          return Get.theme.colorScheme.onSurface.withOpacity(.2);
        }
        return Get.theme.colorScheme.primary;
      },
    ),
    iconSize: const WidgetStatePropertyAll(18),
  );

  OperationType selectedType = OperationType.incoming;

  bool deliveryIncluded = false;
  final List<ItemModel> items = [
    ItemModel(
      id: 1,
      name: 'Clou de diamètre 100',
      price: 100,
      quantity: 10,
      description:
          'Clou provenant des agences de fabrication de fers du pays. Il ne rouille pas.',
    ),
    ItemModel(
      id: 2,
      name: 'Sac de ciment',
      price: 6000,
      quantity: 20,
      description: 'This is item 2',
    )
  ];

  Map<ItemModel, int> itemsXQuantity = {};

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: widget.invoiceController,
                  decoration: InputDecoration(
                    labelText: 'invoice_number'.tr,
                    helperText: "we_will_generate_one_if_it_is_empty".tr,
                    hintText: "1234120098",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: Icon(
                      Icons.receipt_outlined,
                      color: Get.theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: widget.dateController,
                  canRequestFocus: false,
                  decoration: InputDecoration(labelText: 'date'.tr),
                  onTap: pickDate,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("type_of_operation".tr),
              const SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: pickOperationType,
                  child: IgnorePointer(
                    child: RadioListTile<OperationType>(
                      selected: true,
                      value: selectedType,
                      groupValue: selectedType,
                      dense: true,
                      onChanged: (type) {
                        widget.typeController.text = type!.name;
                      },
                      title: Text(
                        selectedType.name.capitalize!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      subtitle: Text("tap_to_change".tr),
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      activeColor: selectedType.color,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: selectedType.color, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("items".tr),
              PickItemWidget(
                items: items,
                onSelected: addItem,
                buttonLabel: "add_an_item".tr,
                buttonIcon: Icons.add,
              )
            ],
          ),
          buildOperationItems(),
          const SizedBox(height: 16),
          TextFormField(
            controller: widget.amountController,
            decoration: InputDecoration(
              labelText: 'total_amount'.tr,
              helperText: "the_total_amount_of_the_operation_on_the_invoice".tr,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'please_fill_this_field'.tr;
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Checkbox(
                value: deliveryIncluded,
                onChanged: (value) {
                  setState(() {
                    deliveryIncluded = value!;
                  });
                  if (value == true) {
                    setTransport();
                  } else {
                    widget.transportCostController.clear();
                    widget.transportTypeController.clear();
                  }
                },
                activeColor: Get.theme.colorScheme.primary,
                visualDensity: VisualDensity.compact,
              ),
              Text("delivery_included".tr),
              if (widget.transportTypeController.text.isNotEmpty) ...[
                const Spacer(),
                TextButton(
                  onPressed: setTransport,
                  style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.zero),
                    visualDensity: VisualDensity.compact,
                  ),
                  child: Text("change".tr),
                )
              ]
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: widget.commentController,
            decoration: InputDecoration(
              labelText: 'additional_information_comments'.tr,
              hintText: "any_additional_informations_that_you_want_to_save".tr,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            maxLines: 4,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget buildOperationItems() {
    if (itemsXQuantity.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.onSurface.withOpacity(.1),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        alignment: Alignment.center,
        child: Text(
          "no_items_selected".tr,
          style: Get.textTheme.bodyMedium,
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemsXQuantity.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        ItemModel item = itemsXQuantity.keys.elementAt(index);
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            setState(() {
              itemsXQuantity.remove(item);
            });
          },
          background: Container(
            color: Get.theme.cardColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
          child: ListTile(
            title: Text(item.name),
            visualDensity: VisualDensity.compact,
            contentPadding: EdgeInsets.zero,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    onPressed: itemsXQuantity[item] == 0
                        ? null
                        : () {
                            setState(() {
                              itemsXQuantity.update(item,
                                  (value) => value > 0 ? value - 1 : value);
                            });
                          },
                    style: buttonStyle,
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                ),
                Text("${itemsXQuantity[item]}",
                    style: Get.textTheme.bodyMedium),
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        itemsXQuantity.update(item, (value) => value + 1);
                      });
                    },
                    style: buttonStyle,
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void addItem(ItemModel item) {
    setState(() {
      itemsXQuantity.update(item, (value) => value + 1, ifAbsent: () => 1);
    });
    Get.back();
  }

  void setTransport() {
    Get.dialog(
      AlertDialog(
        title: Text("transport".tr),
        content: TransportForm(
          costController: widget.transportCostController,
          methodController: widget.transportTypeController,
        ),
        actionsAlignment: MainAxisAlignment.end,
        actions: [
          TextButton(
            onPressed: Get.back,
            style: ButtonStyle(
              backgroundColor:
                  WidgetStatePropertyAll(Get.theme.colorScheme.primary),
              foregroundColor:
                  WidgetStatePropertyAll(Get.theme.colorScheme.onPrimary),
            ),
            child: Text("save".tr),
          ),
        ],
      ),
      name: "Dialog - ${"transport".tr}",
    ).then((_) {
      setState(() {
        if (widget.transportTypeController.text.isEmpty) {
          deliveryIncluded = false;
        }
      });
    });
  }

  void pickOperationType() {
    Get.dialog(
      AlertDialog(
        title: Text("pick_operation_type".tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: OperationType.values.map((type) {
            return ListTile(
              title: Text(type.name.capitalize!),
              subtitle: Text("tap_to_select".tr),
              visualDensity: VisualDensity.compact,
              contentPadding: EdgeInsets.zero,
              trailing: Icon(
                Icons.ads_click_outlined,
                color: Get.theme.colorScheme.onSurface,
              ),
              onTap: () {
                setState(() {
                  selectedType = type;
                });
                Get.back();
              },
            );
          }).toList(),
        ),
      ),
      name: "Dialog - ${"pick_operation_type".tr}",
    );
  }

  void pickDate() async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now(),
        helpText: "pick_the_operation_execution_date".tr,
        routeSettings: RouteSettings(
            name: 'Dialog - ${"pick_the_operation_execution_date".tr}'));
    if (selectedDate != null) {
      widget.dateController.text = selectedDate.toString().split(" ")[0];
    }
  }
}
