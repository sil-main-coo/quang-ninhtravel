import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static SharedPreferences? _sharedPreferences;

  SharedPreferencesManager() {
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }

  Future<bool> putString(String key, String value) async=>
      (await _sharedPreferences?.setString(key, value)) ?? false;

  String? getString(String key) => _sharedPreferences?.getString(key);

  Future<bool> putInt(String key, int value) async=>
      (await _sharedPreferences?.setInt(key, value)) ?? false;

  int? getInt(String key) => _sharedPreferences?.getInt(key);

  Future<bool> clear()async => (await _sharedPreferences?.clear()) ?? false;
}