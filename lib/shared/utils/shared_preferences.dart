import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String USER_KEY = 'user';

final sharedPreferenceProvider = Provider.autoDispose<SharedPreferencesHelper>((ref) {
  return SharedPreferencesHelper();
});

class SharedPreferencesHelper {
  static final SharedPreferencesHelper _singleton = SharedPreferencesHelper._internal();

  SharedPreferencesHelper._internal();

  factory SharedPreferencesHelper() => _singleton;

  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  SharedPreferences? get preferences {
    if (_preferences != null) {
      return _preferences;
    }
    throw Exception(
        'SharedPreferencesHelper has not been initialized. Call init() before accessing preferences.');
  }

  Future<void> clear() async {
    await preferences!.clear();
  }
}
