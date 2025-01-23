import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:stock_pro/controllers/settings/backup_controller.dart';
import 'package:stock_pro/utils/constants.dart';

class BackupView extends GetView<BackupController> {
  const BackupView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BackupController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: Text('backup_and_restore'.tr)),
          body: Container(
            color: Get.theme.colorScheme.onSurface.withOpacity(.05),
            height: Get.size.height,
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: [
                Card(
                  color: Get.theme.colorScheme.surface,
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                        "keep_your_data_safe_with_our_backup_and_restore_feature"
                            .tr),
                  ),
                ),
                const SizedBox(height: 16),
                getStorageCard(),
                const SizedBox(height: 16),
                Card(
                  color: Get.theme.colorScheme.surface,
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("backup_restore".tr,
                            style: Get.textTheme.bodyLarge),
                        const SizedBox(height: 12),
                        buildButtons(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _importantNoticeCard(),
              ],
            ),
          ),
        );
      },
    );
  }

  Card getStorageCard() {
    return Card(
      color: Get.theme.colorScheme.surface,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("storage_location".tr, style: Get.textTheme.bodyLarge),
            const Text(AppConstants.appFolderPath),
          ],
        ),
      ),
    );
  }

  Widget buildButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(20),
                ),
              ),
              side: BorderSide(width: 1, color: Get.theme.colorScheme.primary),
            ),
            onPressed: controller.backingUp ? null : controller.saveBackup,
            child: controller.backingUp
                ? LoadingAnimationWidget.staggeredDotsWave(
                    color: Get.theme.colorScheme.primary, size: 24)
                : Text("create_backup".tr, textAlign: TextAlign.center),
          ),
        ),
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.horizontal(right: Radius.circular(20)),
              ),
              side: BorderSide(width: 1, color: Get.theme.colorScheme.primary),
            ),
            onPressed: controller.restoreBackup,
            child: Text("restore_backup".tr, textAlign: TextAlign.center),
          ),
        ),
      ],
    );
  }

  Widget _importantNoticeCard() {
    return AnimatedScale(
      scale: controller.cardScale,
      duration: const Duration(milliseconds: 300),
      child: Card(
        color: Get.theme.colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.warning_amber_outlined,
                      color: Get.theme.colorScheme.error),
                  const SizedBox(width: 8),
                  Text(
                    'important'.tr,
                    style: Get.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Get.theme.colorScheme.error,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('you_should_restart_your_app_to_finalize_the_backup_restore'
                  .tr),
            ],
          ),
        ),
      ),
    );
  }
}
