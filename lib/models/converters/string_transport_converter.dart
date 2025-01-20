import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:stock_pro/models/transport_model.dart';

class StringTransportConverter
    implements JsonConverter<TransportModel, String> {
  const StringTransportConverter();

  @override
  TransportModel fromJson(String json) {
    return TransportModel.fromJson(jsonDecode(json));
  }

  @override
  String toJson(TransportModel object) {
    return jsonEncode(object.toJson());
  }
}
