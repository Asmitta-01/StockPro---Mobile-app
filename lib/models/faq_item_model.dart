import 'package:json_annotation/json_annotation.dart';

part 'faq_item_model.g.dart';

@JsonSerializable()
class FAQItemModel {
  String question;
  String answer;

  FAQItemModel({required this.question, required this.answer});

  factory FAQItemModel.fromJson(Map<String, dynamic> json) =>
      _$FAQItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$FAQItemModelToJson(this);
}
