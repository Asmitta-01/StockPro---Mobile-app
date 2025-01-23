import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:stock_pro/controllers/settings/privacy_policy_controller.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrivacyPolicyController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('privacy_policy'.tr),
            actions: [
              IconButton(
                onPressed: controller.share,
                icon: const Icon(Icons.share_rounded),
              )
            ],
          ),
          body: Container(
            color: Get.theme.colorScheme.onSurface.withOpacity(.05),
            height: Get.size.height,
            child: controller.isLoading
                ? Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Get.theme.colorScheme.primary,
                      size: 50,
                    ),
                  )
                : controller.privacyPolicy.isEmpty
                    ? _errorWidget()
                    : Markdown(
                        data: controller.privacyPolicy,
                        selectable: true,
                      ),
          ),
        );
      },
    );
  }

  Widget _errorWidget() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Text("an_error_occurred_while_loading_data".tr),
    );
  }
}
