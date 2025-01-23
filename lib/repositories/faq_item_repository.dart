import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stock_pro/models/faq_item_model.dart';

class FaqItemRepository {
  FaqItemRepository._();

  static final FaqItemRepository instance = FaqItemRepository._();

  Future<List<FAQItemModel>> getAll() async {
    String locale = Get.locale?.languageCode ?? 'en';
    // Load FAQ items from a JSON file
    final String jsonString =
        await rootBundle.loadString('assets/data/faqs.$locale.json');
    final List<dynamic> jsonData = json.decode(jsonString);

    // Convert JSON to list of FAQItemModel objects
    return jsonData.map((item) => FAQItemModel.fromJson(item)).toList();
  }
}
