import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ItemModel {
  int? id;
  String name;
  double price;
  String? image;
  String description;
  int quantity;
  final DateTime createdAt;

  int stockThreshold = 0;

  double get estimatedStockValue => price * quantity;

  ItemModel({
    this.id,
    required this.name,
    required this.price,
    this.image,
    required this.description,
    required this.quantity,
    required this.createdAt,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}
