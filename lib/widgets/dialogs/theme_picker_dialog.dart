import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/controllers/my_controller.dart';

class ThemePickerDialog extends StatefulWidget {
  ThemePickerDialog({super.key});

  final MyController appController = Get.find();

  @override
  State<StatefulWidget> createState() => ThemePickerDialogState();
}

class ThemePickerDialogState extends State<ThemePickerDialog> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    _themeMode = widget.appController.themeMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('theme_settings'.tr),
      contentPadding: const EdgeInsets.all(8),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: ThemeMode.values
            .map((mode) => RadioListTile<ThemeMode>(
                  value: mode,
                  groupValue: _themeMode,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: _updateThemeMode,
                  fillColor:
                      WidgetStatePropertyAll(Get.theme.colorScheme.primary),
                  title: Text(
                    _modeToString(mode),
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                  visualDensity: VisualDensity.compact,
                ))
            .toList(),
      ),
      actionsPadding: const EdgeInsets.all(8),
      actions: [
        TextButton(onPressed: Get.back, child: Text('cancel'.tr)),
        TextButton(onPressed: saveThemeMode, child: Text('save'.tr))
      ],
    );
  }

  String _modeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'system_theme'.tr;
      case ThemeMode.light:
        return 'light_theme'.tr;
      case ThemeMode.dark:
        return 'dark_theme'.tr;
    }
  }

  void _updateThemeMode(ThemeMode? mode) {
    setState(() {
      _themeMode = mode!;
    });
  }

  void saveThemeMode() {
    widget.appController.setThemeMode(_themeMode);
    Get.back();
  }
}
