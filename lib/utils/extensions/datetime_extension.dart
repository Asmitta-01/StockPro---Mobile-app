import 'package:get/get_utils/get_utils.dart';

extension DatetimeExtension on DateTime {
  String timeDifference() {
    Duration diff = DateTime.now().difference(this);

    if (diff.inSeconds < 60) {
      return 'just_now'.tr;
    } else if (diff.inMinutes < 60) {
      return 'x_minutes_ago'.trParams({'x': '${diff.inMinutes}'});
    } else if (diff.inHours < 24) {
      return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago';
    } else if (diff.inDays < 2) {
      return 'yesterday'.tr;
    } else {
      return 'x_days_ago'.trParams({'x': '${diff.inDays}'});
    }
  }
}
