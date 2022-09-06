

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_store/models/cities.dart';

import '../models/user.dart';

enum PrefKeys { language, id, name, mobile, loggedIn, gender, active, verified, cityId, storeId, token, nameEn, nameAr, citiesId }

class SharedPrefController {
  SharedPrefController._();

  late SharedPreferences _sharedPreferences;

  static SharedPrefController? _instance;

  factory SharedPrefController() {
    return _instance ??= SharedPrefController._();
  }

  Future<void> initPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void save({required User user}) {
    _sharedPreferences.setBool(PrefKeys.loggedIn.name, true);
    _sharedPreferences.setInt(PrefKeys.id.name, user.id);
    _sharedPreferences.setString(PrefKeys.name.name, user.name);
    _sharedPreferences.setString(PrefKeys.mobile.name, user.mobile);
    _sharedPreferences.setString(PrefKeys.gender.name, user.gender);
    _sharedPreferences.setBool(PrefKeys.active.name, user.active);
    _sharedPreferences.setBool(PrefKeys.verified.name, user.verified);
    _sharedPreferences.setString(PrefKeys.cityId.name, user.cityId);
    _sharedPreferences.setString(PrefKeys.storeId.name, user.storeId);
    _sharedPreferences.setString(PrefKeys.token.name, 'Bearer ${user.token}');
  }

  void citiesSave({required Cities cities}) {
    _sharedPreferences.setInt(PrefKeys.cityId.name, cities.id);
    _sharedPreferences.setString(PrefKeys.nameEn.name, cities.nameEn);
    _sharedPreferences.setString(PrefKeys.nameAr.name, cities.nameAr);
  }

  void changeLanguage({required String langCode}) {
    _sharedPreferences.setString(PrefKeys.language.name, langCode);
  }

  T? getValueFor<T>(String key) {
    if (_sharedPreferences.containsKey(key)) {
      return _sharedPreferences.get(key) as T;
    }
    return null;
  }

  Future<bool> removeValueFor(String key) async {
    if (_sharedPreferences.containsKey(key)) {
      return _sharedPreferences.remove(key);
    }
    return false;
  }

  Future<bool> clear() {
    return _sharedPreferences.clear();
  }

// String get language =>
//     _sharedPreferences.getString(PrefKeys.language.name) ?? 'en';
//
// bool get loggedIn =>
//     _sharedPreferences.getBool(PrefKeys.loggedIn.name) ?? false;
}