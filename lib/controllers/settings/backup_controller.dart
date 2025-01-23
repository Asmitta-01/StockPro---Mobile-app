import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

import 'package:stock_pro/utils/constants.dart';
import 'package:stock_pro/utils/snack_bar_helper.dart';
import 'package:stock_pro/widgets/dialogs/dialog_helper.dart';

class BackupController extends GetxController {
  Database? _database;

  bool backingUp = false;
  bool _permissionGranted = false;
  bool _confirmRestore = false;
  bool restored = false;

  double get cardScale => restored ? 1.08 : 1;

  Timer? _timer;

  BackupController() {
    initDatabase();
    _requestStoragePermission();
  }

  Future<void> initDatabase() async {
    String path = join(await getDatabasesPath(), AppConstants.appDatabaseName);
    _database = await openDatabase(path);
  }

  /// Requests storage permission based on Android SDK version.
  ///
  /// For Android SDK 30 and above, requests MANAGE_EXTERNAL_STORAGE permission.
  /// For lower Android versions, requests basic storage permission.
  Future<void> _requestStoragePermission() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    int sdkVersion = androidInfo.version.sdkInt;

    if (sdkVersion >= 30 &&
        await Permission.manageExternalStorage.status !=
            PermissionStatus.granted) {
      await _requestStorageAccessWithDialog();
    } else {
      if (await Permission.storage.request().isGranted) {
        _permissionGranted = true;
      } else {
        _permissionGranted = false;
        SnackbarHelper.showError("storage_permission_denied".tr);
      }
    }
    update();
  }

  /// Displays a dialog to request storage access permission(API 30 or above)
  /// from the user.
  ///
  /// Shows a confirmation dialog explaining why storage access is needed and
  /// provides options to grant or deny the permission. If granted, sets
  /// [_permissionGranted] to true. If denied, sets [_permissionGranted] to false
  /// and shows an error message.
  Future<void> _requestStorageAccessWithDialog() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DialogHelper.showActionDialog(
        Get.context!,
        title: "grant_access_to_storage".tr,
        primaryAction: () async {
          if (await Permission.manageExternalStorage.request().isGranted) {
            _permissionGranted = true;
            Get.back();
          } else {
            _permissionGranted = false;
            Get.back();
            SnackbarHelper.showError("storage_permission_denied".tr);
          }
        },
        secondaryAction: Get.back,
        primaryActionLabel: "grant".tr,
        secondaryActionLabel: "cancel".tr,
        content: "we_need_access_to_your_storage_to_save_and_load_backups".tr,
      );
    });
  }

  Future<void> autosave() async {
    if (_database != null) {
      String path = join(
        AppConstants.appFolderPath,
        'autosave_${DateTime.now().millisecondsSinceEpoch}_${AppConstants.appDatabaseName}',
      );
      await _database!.execute('VACUUM INTO ?', [path]);
    }
  }

  Future<void> saveBackup() async {
    if (_database == null) {
      SnackbarHelper.showInfo("database_not_loaded".tr);
    }

    if (!_permissionGranted) {
      await _requestStoragePermission();
      if (!_permissionGranted) {
        return;
      }
    }

    backingUp = true;
    update();

    try {
      Directory backupDir = Directory(AppConstants.appFolderPath);
      if (!backupDir.existsSync()) {
        backupDir.createSync(recursive: true);
      }

      String path = join(
          AppConstants.appFolderPath, 'backup_${AppConstants.appDatabaseName}');
      if (File(path).existsSync()) {
        await File(path).delete();
      }
      await _database!.execute('VACUUM INTO ?', [path]);
      SnackbarHelper.showSuccess("backup_done");
    } on PathAccessException {
      SnackbarHelper.showError("storage_permission_denied".tr);
    } catch (e) {
      Get.log(e.toString(), isError: true);
      SnackbarHelper.showError("backup_failed".tr);
    }

    backingUp = false;
    update();
  }

  Future<void> restoreBackup() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      initialDirectory: AppConstants.appFolderPath,
      type: FileType.any,
    );

    String allowedExtension = 'db';

    if (result != null) {
      if (result.files.single.extension != allowedExtension) {
        SnackbarHelper.showError("invalid_file_extension".tr);
      }

      try {
        String? path = result.files.single.path;
        if (path != null && File(path).existsSync()) {
          await _showRestoreAlert();
          if (!_confirmRestore) return;

          _database?.close();

          String dbPath =
              join(await getDatabasesPath(), AppConstants.appDatabaseName);
          await deleteDatabase(dbPath);
          await File(path).copy(dbPath);
          await initDatabase();

          _startTimer();

          SnackbarHelper.showSuccess("restore_done".tr);
        }
      } catch (e) {
        SnackbarHelper.showError("restore_failed".tr);
      }
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      restored = !restored;
      update();
    });
  }

  /// Displays a confirmation dialog for backup restoration.
  ///
  /// Shows an alert dialog asking the user to confirm if they want to restore
  /// from a backup.
  /// Sets [_confirmRestore] to false initially and updates when
  /// the user confirms.
  Future<void> _showRestoreAlert() async {
    _confirmRestore = false;
    update();

    await DialogHelper.showActionDialog(
      Get.context!,
      title: "restore_backup".tr,
      primaryAction: () {
        _confirmRestore = true;
        update();
        Get.back();
      },
      secondaryAction: Get.back,
      primaryActionLabel: "restore".tr,
      secondaryActionLabel: "cancel".tr,
      content: "are_you_sure_you_want_to_restore_backup".tr,
      isDanger: true,
      iconData: Icons.restore_outlined,
    );
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
