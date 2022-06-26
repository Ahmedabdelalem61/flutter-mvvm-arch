import 'package:shared_preferences/shared_preferences.dart';

import '../Presentation/resources/language_manager.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_USER_LOGGED_IN = "PREFS_KEY_USER_LOGGED_IN";
const String PREFS_KEY_ONBOARDING_VIEWED = "PREFS_KEY_ONBOARDING_VIEWED";


class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      // return default lang
       return LanguageType.ENGLISH.getValue();
    }
  }

  Future<void>  userLoggedIn()=>_sharedPreferences.setBool(PREFS_KEY_USER_LOGGED_IN, true);
  Future<void>  onboardingViewd()=>_sharedPreferences.setBool(PREFS_KEY_ONBOARDING_VIEWED, true);
  Future<bool?> isUserLoggedIn()async {
    return _sharedPreferences.getBool(PREFS_KEY_USER_LOGGED_IN)??false;
  }
  Future<bool?> isOnboardingViewd()async{
    return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_VIEWED)??false;
  }

  Future<void> logout()async{
    await _sharedPreferences.remove(PREFS_KEY_USER_LOGGED_IN);
  }

}