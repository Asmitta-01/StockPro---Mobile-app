import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showDialogAsTopSheet(BuildContext context, Widget widget) {
  final theme = Get.theme;
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: theme.colorScheme.onSurface.withAlpha(55),
    transitionDuration: const Duration(milliseconds: 500),
    transitionBuilder: (context, animation, secondaryAnimation, child) =>
        SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
          .animate(animation),
      child: child,
    ),
    pageBuilder: (context, animation, secondaryAnimation) => Align(
      alignment: Alignment.topCenter,
      child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(40)),
          ),
          padding: const EdgeInsets.all(15),
          child: Material(
            child: Stack(
              children: [
                widget,
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 4,
                      width: 40,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onSurface,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    ),
  );
}

void showDialogAsRightSheet(BuildContext context, Widget widget) {
  final theme = Get.theme;
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Fermer",
    barrierColor: theme.colorScheme.onSurface.withAlpha(55),
    transitionDuration: const Duration(milliseconds: 500),
    transitionBuilder: (context, animation, secondaryAnimation, child) =>
        SlideTransition(
      position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
          .animate(animation),
      child: child,
    ),
    pageBuilder: (context, animation, secondaryAnimation) => Align(
      alignment: Alignment.centerRight,
      child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(40)),
          ),
          padding:
              const EdgeInsets.only(left: 8, right: 15, top: 15, bottom: 15),
          child: Material(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: widget,
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 40,
                      width: 4,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onSurface.withAlpha(100),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    ),
  );
}

void showActionDialog(
  BuildContext context, {
  required String title,
  String content = "",
  required Function primaryAction,
  required Function secondaryAction,
  required String primaryActionLabel,
  required String secondaryActionLabel,
  bool isDanger = false,
  IconData? iconData,
}) {
  final theme = Get.theme;
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Text(title, style: Get.textTheme.titleLarge),
                  ),
                ),
                if (iconData != null)
                  Icon(iconData, color: theme.colorScheme.onSurface)
              ],
            ),
            const Divider(),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: RichText(
                text: TextSpan(style: Get.textTheme.bodyMedium, text: content),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 24),
              alignment: AlignmentDirectional.centerEnd,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDanger
                          ? theme.colorScheme.secondary.withAlpha(30)
                          : theme.colorScheme.primary.withAlpha(30),
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 8),
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () => secondaryAction(),
                    child: Text(
                      secondaryActionLabel,
                      style: Get.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDanger
                            ? theme.colorScheme.secondary
                            : theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDanger
                          ? theme.colorScheme.secondary
                          : theme.colorScheme.primary,
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 8),
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () => primaryAction(),
                    child: Text(
                      primaryActionLabel,
                      style: Get.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDanger
                            ? theme.colorScheme.onSecondary
                            : theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void showUniqueActionDialog(
  BuildContext context, {
  required String title,
  String content = "",
  required Function primaryAction,
  required String primaryActionLabel,
  bool isDanger = false,
  IconData? iconData,
}) {
  ThemeData theme = Get.theme;
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Text(
                      title,
                      style: Get.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                if (iconData != null)
                  Icon(
                    iconData,
                    color: theme.colorScheme.onSurface,
                  )
              ],
            ),
            const Divider(),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: RichText(
                text: TextSpan(
                  style: Get.textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                  ),
                  text: content,
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 24),
                alignment: AlignmentDirectional.centerEnd,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDanger
                        ? theme.colorScheme.secondary
                        : theme.colorScheme.primary,
                    padding: const EdgeInsets.all(18),
                  ),
                  onPressed: () => primaryAction(),
                  child: Text(
                    primaryActionLabel,
                    style: Get.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDanger
                          ? theme.colorScheme.onSecondary
                          : theme.colorScheme.onPrimary,
                    ),
                  ),
                )),
          ],
        ),
      ),
    ),
  );
}

void showTimeoutActionDialog(
  BuildContext context, {
  required String title,
  required String content,
  required Function action,
  required String actionLabel,
  Duration timeout = const Duration(seconds: 5),
  bool isDanger = false,
  IconData? iconData,
}) {
  ThemeData theme = Get.theme;
  int timeout_ = timeout.inMilliseconds; // Timeout in seconds
  double progress = 1;
  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        if (progress > 0) {
          Future.delayed(const Duration(milliseconds: 50), () {
            setState(() {
              timeout_ -= 50;
              progress = timeout_ / timeout.inMilliseconds;
            });
            if (timeout_ <= 0) {
              Get.back();
              action();
            }
          });
        }
        return Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                    if (iconData != null)
                      Icon(iconData, color: theme.colorScheme.onSurface)
                  ],
                ),
                const Divider(),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: Get.textTheme.titleSmall!
                          .copyWith(fontWeight: FontWeight.w500),
                      text: content,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(18),
                      backgroundColor: isDanger
                          ? theme.colorScheme.secondary
                          : theme.colorScheme.primary,
                    ),
                    // borderRadius: const BorderRadius.only(
                    //   topLeft: Radius.circular(4),
                    //   topRight: Radius.circular(4),
                    // ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      actionLabel,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isDanger
                            ? theme.colorScheme.onSecondary
                            : theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
                LinearProgressIndicator(
                  value: progress,
                  color: isDanger
                      ? theme.colorScheme.secondary
                      : theme.colorScheme.primary,
                  backgroundColor: isDanger
                      ? theme.colorScheme.secondary.withAlpha(80)
                      : theme.colorScheme.primary.withAlpha(80),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
