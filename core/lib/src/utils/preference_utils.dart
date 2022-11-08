import '../../core.dart';

class PreferenceUtils {
  PreferenceUtils._internal();
  static final PreferenceUtils _instance = PreferenceUtils._internal();
  final _getStorage = GetStorage();
  final _getLocalStorage = GetStorage('Local');

  factory PreferenceUtils() => _instance;

  ///set user token
  setUserToken(String? token) {
    _getStorage.write(StringPreferences.userToken, token);
    printInfo(info: 'set_token: $token');
  }

  ///get user token
  String? getUserToken() => _getStorage.read(StringPreferences.userToken) ?? '';

  ///set user first open
  ///[isFirst] status open app
  setIsUserFirstOpen(bool isFirst) =>
      _getLocalStorage.write(StringPreferences.isFirstOpen, isFirst);

  /// return true if user first open app
  bool? isFirstOpen() => _getLocalStorage.read(StringPreferences.isFirstOpen);

  saveToPreferences(String key, value) => _getStorage.write(key, value);

  getFromPreferences(String key) => _getStorage.read(key);

  saveToLocalPreferences(String key, value) =>
      _getLocalStorage.write(key, value);

  getFromLocalPreferences(String key) => _getLocalStorage.read(key);

  String? getStringPreferences(String key) => _getStorage.read(key);

  int? getIntPreferences(String key) {
    var data = _getStorage.read(key);
    return data.toIntorNull().orZero();
  }

  bool? getBoolPreferences(String key) => _getStorage.read(key);

  double? getDoublePreferences(String key) {
    var data = _getStorage.read(key);
    return data.toDoubleOrNull().orZero();
  }

  void deleteDataInPreferences(String key) async =>
      await _getStorage.remove(key);

  void clearAllData() async => await _getStorage.erase();
}
