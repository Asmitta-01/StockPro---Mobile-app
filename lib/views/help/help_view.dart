import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/controllers/help/help_controller.dart';
import 'package:stock_pro/models/faq_item_model.dart';
import 'package:stock_pro/widgets/drawer_widget.dart';

class HelpView extends GetView<HelpController> {
  const HelpView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HelpController>(
      builder: (controller) {
        return Scaffold(
          key: controller.scaffoldKey,
          appBar: AppBar(
            title: Text('help_and_suggestions'.tr),
            leading: InkWell(
              onTap: controller.openDrawer,
              child: const Icon(Icons.menu_rounded),
            ),
          ),
          drawerEnableOpenDragGesture: true,
          drawer: DrawerWidget(
            currentPage: controller.pagePosition,
            scaffoldKey: controller.scaffoldKey,
          ),
          body: _buildBody(),
          floatingActionButton: FloatingActionButton(
            onPressed: controller.showSendMailConfirmDialog,
            backgroundColor: Get.theme.colorScheme.primary,
            child: const Icon(Icons.feedback_outlined),
          ),
        );
      },
    );
  }

  Widget _helpTextCard() {
    return Card(
      color: Get.theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline_rounded,
                    color: Get.theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text('need_help'.tr,
                    style: Get.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 8),
            Text('help_we_are_here_for_you'.tr),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      color: Get.theme.colorScheme.onSurface.withOpacity(.05),
      height: Get.size.height,
      child: ListView(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        children: [
          _helpTextCard(),
          const SizedBox(height: 16),
          _buildFAQCard(),
        ],
      ),
    );
  }

  Widget _buildFAQCard() {
    return Card(
      color: Get.theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.question_answer_outlined,
                    color: Get.theme.colorScheme.secondary),
                const SizedBox(width: 8),
                Text('FAQ'.tr,
                    style: Get.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
            const Divider(height: 16),
            ListView.builder(
              shrinkWrap: true,
              itemCount: controller.items.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return faqItemToWidget(controller.items[index]);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget faqItemToWidget(FAQItemModel item) {
    return ExpansionTile(
      title: Text(item.question),
      tilePadding: EdgeInsets.zero,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(item.answer),
        )
      ],
    );
  }
}
