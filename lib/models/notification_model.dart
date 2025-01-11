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
}
