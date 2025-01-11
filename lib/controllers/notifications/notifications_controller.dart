import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/models/notification_model.dart';

class NotificationsController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final int pagePosition = 4;

  final List<NotificationModel> notifications = [
    NotificationModel(
      title: "Random title",
      body: "The purpose of this random notification",
      date: DateTime.now(),
      isRead: false,
    ),
    NotificationModel(
      title: "Another random title",
      body: "The purpose of this useless notification",
      date: DateTime.now(),
    ),
    NotificationModel(
      title: "Random title",
      body: "The purpose of this random notification",
      date: DateTime(2025),
    ),
    NotificationModel(
      title: "Another random title",
      body: "The purpose of this useless notification",
      date: DateTime(2025, 1, 5),
    ),
  ];

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }
}
