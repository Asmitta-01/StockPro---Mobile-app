import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:stock_pro/controllers/auth/post_auth_controller.dart';

class PostAuthScreen extends GetView<PostAuthController> {
  const PostAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostAuthController>(builder: (controller) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton.filled(
                  icon: const Icon(Icons.close_sharp),
                  onPressed: controller.close,
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Get.theme.colorScheme.onSurface.withOpacity(.1)),
                      iconColor: WidgetStatePropertyAll(
                          Get.theme.colorScheme.onSurface)),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                "finish_account_setup".tr,
                style: Get.textTheme.headlineSmall!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              Text("to_complete_your_account_setup_please_select_your_user_type"
                  .tr),
              const SizedBox(height: 20),
              getInfoBox(),
              const SizedBox(height: 16),
              Text(
                "step_i".trParams({
                  'a': "${controller.currentPage + 1}",
                  'b': controller.totalPages.toString()
                }),
                style: Get.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: double.infinity,
                child: StepProgressIndicator(
                  totalSteps: controller.totalPages,
                  currentStep: controller.currentPage + 1,
                  selectedColor: Get.theme.colorScheme.onSurface,
                  unselectedColor:
                      Get.theme.colorScheme.onSurface.withOpacity(.2),
                  roundedEdges: const Radius.circular(10),
                ),
              ),
              const SizedBox(height: 18),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: Get.size.height * .45),
                child: PageView(
                  controller: controller.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    getFirstStepPage(),
                    getSecondStepPage(),
                    getThirdStepPage(),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget getInfoBox() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.primary.withOpacity(.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info, color: Get.theme.colorScheme.primary),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              "your_account_is_almost_ready".tr,
            ),
          )
        ],
      ),
    );
  }

  Widget getFirstStepPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "what_kind_of_user_are_you".tr,
          style: Get.textTheme.headlineSmall!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        ...controller.roles.map(
          (role) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: RadioListTile(
              value: role,
              groupValue: controller.selectedRole,
              onChanged: controller.updateSelectedRole,
              // contentPadding: EdgeInsets.zero,
              title: Text(
                role,
                style: Get.textTheme.titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                role == "Proprio" ? "proprio_details".tr : "manager_details".tr,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              // secondary: const Icon(Icons.zoom_out_sharp),
              selectedTileColor: Get.theme.colorScheme.primary.withOpacity(.1),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: role == controller.selectedRole
                      ? Get.theme.colorScheme.primary
                      : Get.theme.colorScheme.onSurface.withOpacity(.2),
                  width: role == controller.selectedRole ? 2.5 : .8,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: controller.switchPage,
              child: Text('next'.tr, style: const TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ],
    );
  }

  Widget getSecondStepPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "whats_your_gender".tr,
          style: Get.textTheme.headlineSmall!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Wrap(
          children: controller.genders
              .map(
                (gender) => Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 12),
                  child: Wrap(
                    children: [
                      InkWell(
                        onTap: () => controller.updateSelectedGender(gender),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 4),
                          decoration: BoxDecoration(
                            color: gender == controller.selectedGender
                                ? Get.theme.colorScheme.primary.withOpacity(.05)
                                : Get.theme.colorScheme.surface,
                            border: Border.all(
                              width: 1.5,
                              color: gender == controller.selectedGender
                                  ? Get.theme.colorScheme.primary
                                  : Get.theme.colorScheme.onSurface,
                            ),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            gender,
                            style: Get.textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: gender == controller.selectedGender
                                  ? Get.theme.colorScheme.primary
                                  : Get.theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => controller.switchPage(false),
              child: Text("previous".tr),
            ),
            const SizedBox(width: 4),
            ElevatedButton(
              onPressed: controller.switchPage,
              child: Text('next'.tr, style: const TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ],
    );
  }

  Widget getThirdStepPage() {
    if (controller.selectedRole == controller.roles.first) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "enter_your_shop_informations".tr,
            style: Get.textTheme.headlineSmall!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: controller.showShopFormSheet,
            child: Text("start".tr),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (controller.savedShop)
                ElevatedButton(
                  onPressed: controller.completeAccount,
                  child:
                      Text('finish'.tr, style: const TextStyle(fontSize: 18)),
                ),
            ],
          ),
        ],
      );
    }

    return _searchStoreWidget();
  }

  Column _searchStoreWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "enter_the_store_token".tr,
          style: Get.textTheme.headlineSmall!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Text("enter_the_store_token".tr),
        const SizedBox(height: 12),
        TextFormField(
          controller: controller.tokenController,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: "stock93hd3ok1d3nm...",
            suffixIcon: InkWell(
              onTap: () {},
              child: const Icon(Icons.paste_sharp),
            ),
          ),
          validator: controller.validateTokenInput,
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: controller.checkingToken
                  ? null
                  : () => controller.switchPage(false),
              child: Text("previous".tr),
            ),
            const SizedBox(width: 4),
            ElevatedButton(
              onPressed: controller.checkToken,
              child: controller.checkingToken
                  ? LoadingAnimationWidget.staggeredDotsWave(
                      color: Get.isDarkMode
                          ? Get.theme.colorScheme.surface
                          : Get.theme.colorScheme.onPrimary,
                      size: 22,
                    )
                  : Text('check'.tr, style: const TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ],
    );
  }
}
