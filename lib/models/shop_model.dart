import 'package:json_annotation/json_annotation.dart';
import 'package:stock_pro/models/converters/integer_bool_converter.dart';
import 'package:stock_pro/models/converters/string_list_converter.dart';

part 'shop_model.g.dart';

@JsonSerializable()
class ShopModel {
  int id;
  String name;
  String? image;
  String? logo;
  String? website;
  String address;
  DateTime createdAt;

  @StringListConverter()
  List<String> categories;

  @IntegerBoolConverter()
  bool active;

  ShopModel({
    required this.id,
    required this.name,
    this.image,
    this.website,
    required this.address,
    this.active = false,
    this.logo,
    required this.categories,
    required this.createdAt,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) =>
      _$ShopModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShopModelToJson(this);
}
