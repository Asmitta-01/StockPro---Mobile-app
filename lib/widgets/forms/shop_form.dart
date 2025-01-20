import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopForm extends StatefulWidget {
  const ShopForm({super.key, required this.fn});

  /// Callback function that handles form data processing.
  ///
  /// This function takes three parameters:
  /// - First parameter: Shop's name
  /// - Second parameter: Shop's website (can be null)
  /// - Third parameter: Shop's address
  final void Function(String, String?, String) fn;

  @override
  ShopFormState createState() => ShopFormState();
}

class ShopFormState extends State<ShopForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? validateField(String? value) {
    if (value == null || value.isEmpty) {
      return "please_fill_this_field".tr;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "fill_this_form".tr,
            style: Get.textTheme.headlineSmall!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: nameController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: "shop_name".tr,
              labelText: "shop_name".tr,
            ),
            validator: validateField,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: websiteController,
            keyboardType: TextInputType.url,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: "shop_website".tr,
              labelText: "shop_website".tr,
              helperText: "the_website_of_your_shop".tr,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: addressController,
            keyboardType: TextInputType.url,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: "town_of_the_shop".tr,
              labelText: "shop_address".tr,
            ),
            validator: validateField,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: submitForm,
                  child: Text('submit'.tr),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.fn(
        nameController.text,
        websiteController.text,
        addressController.text,
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    websiteController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }
}
