import 'dart:convert';

import 'package:dulichquangninh/common/injector/get_it.dart';
import 'package:dulichquangninh/common/session/shared_pref_manager.dart';
import 'package:dulichquangninh/common/session/shared_preferences_keys.dart';
import 'package:dulichquangninh/providers/models/user.dart';

class SessionPref {
  static void saveSession(User user) {
    var preferencesManager = locator.get<SharedPreferencesManager>();
    preferencesManager.putString(
        SharedPrefsKeys.user, jsonEncode(user.toJson()));
  }

  static User getUser() {
    final rawData =
        locator.get<SharedPreferencesManager>().getString(SharedPrefsKeys.user);

    if (rawData != null) {
      return User.fromJson(jsonDecode(rawData));
    }
    return null;
  }

  static Future<void> clearUserData() async {
    await locator.get<SharedPreferencesManager>().clear();
  }
}
