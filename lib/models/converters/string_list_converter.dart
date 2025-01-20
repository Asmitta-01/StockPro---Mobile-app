import 'package:json_annotation/json_annotation.dart';

class StringListConverter implements JsonConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromJson(String json) {
    return json.split(',');
  }

  @override
  String toJson(List<String> object) {
    return object.join(',');
  }
}
