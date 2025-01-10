import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:stock_pro/controllers/auth/signup_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("create_a_new_account".tr),
          leading: InkWell(
            onTap: controller.goBack,
            child: const Icon(Icons.arrow_back),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: StepProgressIndicator(
                  totalSteps: controller.totalPages,
                  currentStep: controller.currentPage + 1,
                  selectedColor: Get.theme.colorScheme.primary,
                  unselectedColor:
                      Get.theme.colorScheme.primary.withOpacity(.2),
                  roundedEdges: const Radius.circular(10),
                ),
              ),
              const SizedBox(height: 18),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: Get.size.height * .4),
                child: PageView(
                  controller: controller.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    getEmailPage(),
                    getFullNamePage(),
                    getBirthdayPage(),
                    getPasswordPage(),
                    getConfirmPasswordPage(),
                  ],
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: controller.goToLoginView,
                child: Text(
                  "already_have_an_account".tr,
                  style: Get.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Get.theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getEmailPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "enter_your_email_address".tr,
          style: Get.textTheme.headlineSmall!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        TextFormField(
          key: controller.emailKey,
          controller: controller.emailController,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: "email".tr,
            label: Text("email".tr),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: controller.validateEmail,
          onFieldSubmitted: (_) => controller.switchPage(),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: controller.switchPage,
                child: controller.checkingEmail
                    ? LoadingAnimationWidget.staggeredDotsWave(
                        color: Get.theme.colorScheme.onPrimary, size: 25)
                    : Text('next'.tr, style: const TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getFullNamePage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "whats_your_name".tr,
          style: Get.textTheme.headlineSmall!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        TextFormField(
          key: controller.nameKey,
          controller: controller.nameController,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            hintText: "full_name".tr,
            label: Text("full_name".tr),
          ),
          keyboardType: TextInputType.name,
          onFieldSubmitted: (_) => controller.switchPage(),
          validator: controller.validateField,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: controller.switchPage,
                child: Text('next'.tr, style: const TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getBirthdayPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "whats_your_birthday".tr,
          style: Get.textTheme.headlineSmall!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Text("your_birthday_information_is_private".tr),
        const SizedBox(height: 12),
        TextFormField(
          key: controller.birthdayKey,
          controller: controller.birthdayController,
          textInputAction: TextInputAction.next,
          readOnly: true,
          decoration: InputDecoration(
            label: Text("birthday".tr),
            suffixIcon: const Icon(Icons.calendar_today),
          ),
          onTap: controller.selectDate,
          validator: controller.validateField,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: controller.switchPage,
                child: Text('next'.tr, style: const TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getPasswordPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "create_a_password".tr,
          style: Get.textTheme.headlineSmall!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Text("create_a_password_with_at_least_six_letters".tr),
        const SizedBox(height: 12),
        TextFormField(
          key: controller.passwordKey,
          controller: controller.passwordController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.visiblePassword,
          obscureText: !controller.passwordVisible,
          decoration: InputDecoration(
            label: Text("password".tr),
            suffixIcon: InkWell(
              onTap: controller.togglePasswordVisibility,
              child: Icon(controller.passwordVisible
                  ? Icons.visibility_off_sharp
                  : Icons.remove_red_eye_rounded),
            ),
          ),
          onFieldSubmitted: (_) => controller.switchPage(),
          validator: controller.validatePassword,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: controller.switchPage,
                child: Text('next'.tr, style: const TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getConfirmPasswordPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "confirm_password".tr,
          style: Get.textTheme.headlineSmall!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Text("please_enter_the_same_password_again_to_confirm".tr),
        const SizedBox(height: 12),
        TextFormField(
          key: controller.confirmPwdKey,
          controller: controller.confirmPwdController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.visiblePassword,
          obscureText: !controller.passwordVisible,
          decoration: InputDecoration(
            label: Text("confirm_password".tr),
            suffixIcon: InkWell(
              onTap: controller.togglePasswordVisibility,
              child: Icon(controller.passwordVisible
                  ? Icons.visibility_off_sharp
                  : Icons.remove_red_eye_rounded),
            ),
          ),
          onFieldSubmitted: (_) => controller.switchPage(),
          validator: controller.validateConfirmPassword,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: controller.signingUp ? () {} : controller.switchPage,
                child: controller.signingUp
                    ? LoadingAnimationWidget.staggeredDotsWave(
                        color: Get.theme.colorScheme.onPrimary, size: 25)
                    : Text(
                        'create_my_account'.tr,
                        style: const TextStyle(fontSize: 20),
                      ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
