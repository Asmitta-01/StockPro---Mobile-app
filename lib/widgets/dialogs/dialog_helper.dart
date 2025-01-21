import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {
  // Private constructor to prevent instantiation
  DialogHelper._();

  // Constants for common values
  static const _defaultDuration = Duration(milliseconds: 500);
  static const _defaultRadius = 40.0;
  static const _smallRadius = 8.0;
  static const _defaultPadding = 15.0;

  static BoxDecoration _buildRoundedDecoration(Color color, double radius) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );
  }

  static ButtonStyle _buildButtonStyle({
    required Color backgroundColor,
    double radius = _smallRadius,
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      side: BorderSide.none,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
    );
  }

  static void showTopSheet(BuildContext context, Widget widget) {
    final theme = Get.theme;
    final size = MediaQuery.of(context).size;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: theme.colorScheme.onSurface.withAlpha(55),
      transitionDuration: _defaultDuration,
      transitionBuilder: _buildSlideTransition,
      pageBuilder: (context, _, __) => _TopSheetContent(
        theme: theme,
        size: size,
        widget: widget,
      ),
    );
  }

  static void showRightSheet(BuildContext context, Widget widget) {
    final theme = Get.theme;
    final size = MediaQuery.of(context).size;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Close",
      barrierColor: theme.colorScheme.onSurface.withAlpha(55),
      transitionDuration: _defaultDuration,
      transitionBuilder: _buildHorizontalSlideTransition,
      pageBuilder: (context, _, __) => _RightSheetContent(
        theme: theme,
        size: size,
        widget: widget,
      ),
    );
  }

  static void showActionDialog(
    BuildContext context, {
    required String title,
    String content = "",
    Widget contentWidget = const SizedBox.shrink(),
    required VoidCallback primaryAction,
    required VoidCallback secondaryAction,
    required String primaryActionLabel,
    required String secondaryActionLabel,
    bool isDanger = false,
    IconData? iconData,
  }) {
    assert(
      content.isEmpty || contentWidget == const SizedBox.shrink(),
      "You can't provide both content and contentWidget",
    );

    final theme = Get.theme;

    showDialog(
      context: context,
      builder: (context) => _ActionDialogContent(
        theme: theme,
        title: title,
        content: content,
        contentWidget: contentWidget,
        primaryAction: primaryAction,
        secondaryAction: secondaryAction,
        primaryActionLabel: primaryActionLabel,
        secondaryActionLabel: secondaryActionLabel,
        isDanger: isDanger,
        iconData: iconData,
      ),
    );
  }

  static Widget _buildSlideTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, -1),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  static Widget _buildHorizontalSlideTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }
}

class _TopSheetContent extends StatelessWidget {
  final ThemeData theme;
  final Size size;
  final Widget widget;

  const _TopSheetContent({
    required this.theme,
    required this.size,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: size.height * 0.8,
        decoration: DialogHelper._buildRoundedDecoration(
          theme.colorScheme.surface,
          DialogHelper._defaultRadius,
        ),
        padding: const EdgeInsets.all(DialogHelper._defaultPadding),
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
                    decoration: DialogHelper._buildRoundedDecoration(
                      theme.colorScheme.onSurface,
                      DialogHelper._defaultRadius,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _RightSheetContent extends StatelessWidget {
  final ThemeData theme;
  final Size size;
  final Widget widget;

  const _RightSheetContent({
    required this.theme,
    required this.size,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: size.width * 0.95,
        decoration: DialogHelper._buildRoundedDecoration(
          theme.colorScheme.surface,
          DialogHelper._defaultRadius,
        ),
        padding: const EdgeInsets.fromLTRB(8, 15, 15, 15),
        child: Material(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: widget,
              ),
              _buildLeftIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeftIndicator() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          height: 40,
          width: 4,
          decoration: DialogHelper._buildRoundedDecoration(
            theme.colorScheme.onSurface.withAlpha(100),
            DialogHelper._defaultRadius,
          ),
        ),
      ),
    );
  }
}

class _ActionDialogContent extends StatelessWidget {
  final ThemeData theme;
  final String title;
  final String content;
  final Widget contentWidget;
  final VoidCallback primaryAction;
  final VoidCallback secondaryAction;
  final String primaryActionLabel;
  final String secondaryActionLabel;
  final bool isDanger;
  final IconData? iconData;

  const _ActionDialogContent({
    required this.theme,
    required this.title,
    required this.content,
    required this.primaryAction,
    required this.secondaryAction,
    required this.primaryActionLabel,
    required this.secondaryActionLabel,
    this.isDanger = false,
    this.iconData,
    required this.contentWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
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
          children: [
            _buildHeader(),
            const Divider(),
            _buildContent(),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Text(title, style: Get.textTheme.titleLarge),
          ),
        ),
        if (iconData != null) Icon(iconData, color: theme.colorScheme.onSurface)
      ],
    );
  }

  Widget _buildContent() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: contentWidget != const SizedBox.shrink()
          ? contentWidget
          : RichText(
              text: TextSpan(style: Get.textTheme.bodyMedium, text: content),
            ),
    );
  }

  Widget _buildActions() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      alignment: AlignmentDirectional.centerEnd,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildActionButton(
            label: secondaryActionLabel,
            onPressed: secondaryAction,
            isSecondary: true,
          ),
          const SizedBox(width: 8),
          _buildActionButton(
            label: primaryActionLabel,
            onPressed: primaryAction,
            isSecondary: false,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required VoidCallback onPressed,
    required bool isSecondary,
  }) {
    final Color backgroundColor = isSecondary
        ? (isDanger ? theme.colorScheme.secondary : theme.colorScheme.primary)
            .withAlpha(30)
        : (isDanger ? theme.colorScheme.secondary : theme.colorScheme.primary);

    final Color textColor = isSecondary
        ? (isDanger ? theme.colorScheme.secondary : theme.colorScheme.primary)
        : (isDanger
            ? theme.colorScheme.onSecondary
            : theme.colorScheme.onPrimary);

    return ElevatedButton(
      style: DialogHelper._buildButtonStyle(backgroundColor: backgroundColor),
      onPressed: onPressed,
      child: Text(
        label,
        style: Get.textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
