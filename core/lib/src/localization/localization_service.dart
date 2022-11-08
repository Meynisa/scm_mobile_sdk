import 'package:core/core.dart';
import 'package:scm_mobile_sdk/main_lib.dart';

class LocalizationService {
  static Map<String, Map<String, String>> translationKeys = {
    'en': en,
    'id': id_ID
  };

  String? _loadLanguageFromLocal() =>
      PreferenceUtils()
          .getFromLocalPreferences(StringPreferences.localLanguage) ??
      'en';

  Locale loadLanguages() => _loadLanguageFromLocal() == 'en'
      ? Locale('en', 'US')
      : Locale('id', 'ID');

  _saveLanguageToBox(String lang) => PreferenceUtils()
      .saveToLocalPreferences(StringPreferences.localLanguage, lang);

  static final List<LanguageModel> languages = [
    LanguageModel('English', 'en'),
    LanguageModel('Indonesia', 'id')
  ];

  switchLanguage(String lang) {
    Locale locale = new Locale(lang);
    Get.updateLocale(locale);
    _saveLanguageToBox(lang);
  }
}

class LanguageModel {
  LanguageModel(
    this.language,
    this.symbol,
  );

  String language;
  String symbol;
}
