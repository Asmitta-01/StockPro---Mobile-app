import 'package:json_annotation/json_annotation.dart';

part 'shop_model.g.dart';

@JsonSerializable()
class ShopModel {
  int id;
  String name;
  String? image;
  String? logo;
  String? website;
  String address;
  List<String> categories;
  bool active;
  DateTime createdAt;

  ShopModel({
    required this.id,
    required this.name,
    required this.image,
    this.website,
    required this.address,
    this.active = false,
    required this.logo,
    required this.categories,
    required this.createdAt,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) =>
      _$ShopModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShopModelToJson(this);
}
