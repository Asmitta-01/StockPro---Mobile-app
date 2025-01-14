import 'package:stock_pro/models/helpers/language_model.dart';
import 'package:stock_pro/utils/image_data.dart';

class AppConstants {
  static const String appName = "StockPro";
  static const String appSupportMail = "tiwabrayan@gmail.com";
  static const String countryCode = '_country_code';
  static const String languageCode = '_language_code';

  static List<LanguageModel> languages = [
    LanguageModel(
      imageUrl: ImageData.french,
      languageName: 'Français',
      countryCode: 'FR',
      languageCode: 'fr',
    ),
    LanguageModel(
      imageUrl: ImageData.english,
      languageName: 'English',
      countryCode: 'US',
      languageCode: 'en',
    ),
  ];
}
