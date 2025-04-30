import 'package:assam_edu/core/app_constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageServices {
  late final SharedPreferences _prefs;

  Future<StorageServices> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  //user after completing the onboarding screen..
  Future<bool> setDeviceFirstOpen(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  bool getDeviceFirstOpen() {
    return _prefs.getBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME) ?? false;
  }

  //Save user type for different routes
  // Future<bool> setUserType(String key, String value) async {
  //   return await _prefs.setString(key, value);
  // }

  String getUserType() {
    return _prefs.getString(AppConstants.USER_TYPE) ?? '';
  }

  String getSignInType() {
    return _prefs.getString(AppConstants.SIGN_IN_TYPE) ?? '';
  }

  //user after logged in..
  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  String getUserToken() {
    return _prefs.getString(AppConstants.STORAGE_USER_TOKEN_KEY) ?? '';
  }

  bool getIsLoggedIn() {
    return _prefs.getString(AppConstants.STORAGE_USER_TOKEN_KEY) == null
        ? false
        : true;
  }

  String getUserProfile() {
    return _prefs.getString(AppConstants.STORAGE_USER_PROFILE_KEY) ?? '';
  }

  // Delete any shared pref..
  Future<bool> deleteSharedPrefValue(String key) async {
    return await _prefs.remove(key);
  }

  Future<bool> storeEduProfile(List<String> items) {
    return _prefs.setStringList(AppConstants.EDUCATOR_PROFILE_INFO, items);
  }

  List<String> getEduProfile(String key) {
    return _prefs.getStringList(key) ?? [];
  }
}
