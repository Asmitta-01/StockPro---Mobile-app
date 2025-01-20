import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/controllers/my_controller.dart';
import 'package:stock_pro/models/helpers/language_model.dart';
import 'package:stock_pro/utils/constants.dart';

class LanguageBottomSheetWidget extends StatefulWidget {
  LanguageBottomSheetWidget({super.key});

  final MyController appController = Get.find();

  @override
  State<LanguageBottomSheetWidget> createState() =>
      _LanguageBottomSheetWidgetState();
}

class _LanguageBottomSheetWidgetState extends State<LanguageBottomSheetWidget> {
  late LanguageModel selectedLanguage;

  @override
  void initState() {
    selectedLanguage = AppConstants.languages.firstWhere(
        (element) => element.languageCode == Get.locale!.languageCode);
    super.initState();
  }

  void updateSelectedLanguage(LanguageModel languageModel) {
    setState(() {
      selectedLanguage = languageModel;
    });
  }

  void changeAppLanguage() {
    widget.appController.setLanguage(
      Locale(
        selectedLanguage.languageCode!,
        selectedLanguage.countryCode,
      ),
    );
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 18),
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          height: 5,
          width: 45,
          decoration: BoxDecoration(
            color: Get.theme.disabledColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(height: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text('language_choice'.tr, style: Get.textTheme.titleLarge),
          const SizedBox(height: 12),
          Text(
            'choose_your_language'.tr,
            style: Get.textTheme.titleSmall,
          ),
        ]),
        const SizedBox(height: 24),
        Flexible(
          child: SingleChildScrollView(
            child: ListView.builder(
              itemCount: AppConstants.languages.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              itemBuilder: (context, index) {
                return languageCardWidget(
                  languageModel: AppConstants.languages[index],
                );
              },
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Get.theme.scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 10,
              )
            ],
          ),
          margin: const EdgeInsets.only(top: 12),
          child: ElevatedButton(
            onPressed: changeAppLanguage,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              foregroundColor: Colors.white,
              backgroundColor: Get.theme.colorScheme.primary,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            ),
            child: Text(
              'update'.tr,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ]),
    );
  }

  Widget languageCardWidget({required LanguageModel languageModel}) {
    return InkWell(
      onTap: () {
        updateSelectedLanguage(languageModel);
      },
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selectedLanguage == languageModel
              ? Get.theme.colorScheme.primaryContainer.withOpacity(.5)
              : null,
          borderRadius: BorderRadius.circular(10),
          border: selectedLanguage == languageModel
              ? Border.all(
                  color: Get.theme.colorScheme.primary.withOpacity(0.2))
              : null,
        ),
        child: Row(
          children: [
            Text(languageModel.languageName!),
            const Spacer(),
            selectedLanguage == languageModel
                ? Icon(
                    Icons.check_circle,
                    color: Get.theme.colorScheme.primary,
                    size: 25,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
