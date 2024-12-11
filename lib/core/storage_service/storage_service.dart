import 'package:assam_edu/core/app_constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageServices {
  late final SharedPreferences _prefs;

  Future<StorageServices> init() async {
    _prefs = await SharedPreferences.getInstance();
    print("_prefs is initialized");
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
  Future<bool> setUserType(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  String getUserType() {
    return _prefs.getString(AppConstants.USER_TYPE) ?? '';
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

  Future<bool> deleteDeviceFirstOpen() async {
    return await _prefs.remove(AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME);
  }

  Future<bool> deleteUserToken() async {
    return await _prefs.remove(AppConstants.STORAGE_USER_TOKEN_KEY);
  }
}
