import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:stock_pro/controllers/auth/login_controller.dart';
import 'package:stock_pro/utils/image_data.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) => Scaffold(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      foregroundColor: Get.theme.colorScheme.onSurface,
                      textStyle: Get.textTheme.bodyMedium,
                      side: BorderSide.none,
                      backgroundColor:
                          Get.theme.colorScheme.surface.withOpacity(.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.translate, size: 16),
                        const SizedBox(width: 4),
                        Text(controller
                            .getSelectedLanguageModel()
                            .languageName!),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.size.height / 10),
                  Image.asset(
                    Get.isDarkMode ? ImageData.logoDark : ImageData.logo,
                    width: 230,
                  ),
                ],
              ),
              const Spacer(),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.usernameController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(hintText: "email".tr),
                      validator: controller.validateField,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: controller.passwordController,
                      textInputAction: TextInputAction.done,
                      obscureText: !controller.passwordVisible,
                      decoration: InputDecoration(
                        hintText: "password".tr,
                        suffixIcon: InkWell(
                          onTap: controller.togglePasswordVisibility,
                          child: Icon(
                            controller.passwordVisible
                                ? Icons.visibility_off_rounded
                                : Icons.remove_red_eye_rounded,
                          ),
                        ),
                      ),
                      validator: controller.validateField,
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed:
                                controller.loggingIn ? () {} : controller.login,
                            child: controller.loggingIn
                                ? LoadingAnimationWidget.staggeredDotsWave(
                                    color: Get.isDarkMode
                                        ? Get.theme.colorScheme.surface
                                        : Get.theme.colorScheme.onPrimary,
                                    size: 25,
                                  )
                                : Text(
                                    'sign_in'.tr,
                                    style: const TextStyle(fontSize: 22),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: controller.goToForgotPasswordView,
                child: Text(
                  "forgot_password".tr,
                  style: Get.textTheme.titleMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: controller.goToRegisterView,
                      child: Text(
                        'create_a_new_account'.tr,
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
