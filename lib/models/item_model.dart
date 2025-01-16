import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  int? id;
  String name;
  double price;
  String? image;
  String description;
  int quantity;
  DateTime? _createdAt;

  int? _stockThreshold;

  int get stockThreshold => _stockThreshold!;

  set stockThreshold(int value) {
    _stockThreshold = value;
  }

  DateTime get createdAt => _createdAt!;

  double get estimatedStockValue => price * quantity;

  ItemModel({
    this.id,
    required this.name,
    required this.price,
    this.image,
    required this.description,
    required this.quantity,
  }) {
    _createdAt = DateTime.now();
  }

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}
