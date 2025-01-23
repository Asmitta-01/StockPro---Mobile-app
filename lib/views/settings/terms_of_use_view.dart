import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:stock_pro/controllers/settings/terms_of_use_controller.dart';

class TermsOfUseView extends GetView<TermsOfUseController> {
  const TermsOfUseView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TermsOfUseController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: Text('terms_of_use'.tr)),
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
                : controller.termsOfUse.isEmpty
                    ? _errorWidget()
                    : Markdown(data: controller.termsOfUse),
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
