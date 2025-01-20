import 'package:json_annotation/json_annotation.dart';

class IntegerBoolConverter implements JsonConverter<bool, int> {
  const IntegerBoolConverter();

  @override
  bool fromJson(int json) {
    return json == 1 ? true : false;
  }

  @override
  int toJson(bool object) {
    return object ? 1 : 0;
  }
}
