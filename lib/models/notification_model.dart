import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  String title;
  String body;
  bool isRead;
  DateTime date;

  NotificationModel({
    required this.title,
    required this.body,
    required this.date,
    this.isRead = true,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
