import 'package:core/core.dart';
import 'package:scm_mobile_sdk/main_lib.dart';

class ThemeService {
  /// Get isDarkMode info from local storage and return ThemeMode
  ThemeMode get theme => loadThemeFromLocal() != DictionaryUtil.default_theme
      ? loadThemeFromLocal() == DictionaryUtil.light_mode
          ? ThemeMode.light
          : ThemeMode.dark
      : ThemeMode.light;

  /// Load isDarkMode from local storage and if it's empty, returns false (that means default theme is light)
  String? loadThemeFromLocal() =>
      PreferenceUtils().getStringPreferences(StringPreferences.localTheme) ??
      DictionaryUtil.default_theme;

  /// Save isDarkMode to local storage
  _saveThemeToBox(String isDarkMode) => PreferenceUtils()
      .saveToPreferences(StringPreferences.localTheme, isDarkMode);

  /// Switch theme and save to local storage
  void switchTheme(String mode) {
    Get.changeThemeMode(mode != DictionaryUtil.default_theme
        ? mode == DictionaryUtil.light_mode
            ? ThemeMode.light
            : ThemeMode.dark
        : ThemeMode.light);
    _saveThemeToBox(mode);
  }
}
