import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  final SharedPreferences _sharedPref;

  SharedPref({required SharedPreferences sharedPref})
    : _sharedPref = sharedPref;

  Future<bool> setString(String key, String value) async {
    return await _sharedPref.setString(key, value);
  }

  String? getString(String key) {
    return _sharedPref.getString(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _sharedPref.setBool(key, value);
  }

  bool? getBool(String key) {
    return _sharedPref.getBool(key);
  }

  Future<bool> remove(String key) async {
    return await _sharedPref.remove(key);
  }

  Future<bool> clear() async {
    return await _sharedPref.clear();
  }
}