import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:stock_pro/models/item_model.dart';

class StringMapConverter implements JsonConverter<Map<ItemModel, int>, String> {
  const StringMapConverter();

  @override
  Map<ItemModel, int> fromJson(String json) {
    final Map data = jsonDecode(json);
    return data.map((k, v) {
      final itemModel = ItemModel.fromJson(jsonDecode(k));
      return MapEntry(itemModel, v);
    });
  }

  @override
  String toJson(Map<ItemModel, int> object) {
    return jsonEncode(object.map((k, v) {
      final String itemKey = jsonEncode(k.toJson());
      return MapEntry(itemKey, v);
    }));
  }
}
