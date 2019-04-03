import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static PrefsService _instance;

  PrefsService.init(this._prefs) {
    _instance = this;
  }

  factory PrefsService() {
    return _instance;
  }

  final SharedPreferences _prefs;

  Future<bool> storeByKey(String key, String data) async {
    return _prefs.setString(key, data);
  }

  Future<void> clearSharedPreferences() async {
    return await _prefs.clear();
  }
}
