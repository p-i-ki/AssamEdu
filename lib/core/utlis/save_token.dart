import '../../init_dependencies.dart';
import '../app_constants/app_constants.dart';
import '../storage_service/storage_service.dart';

class StoreTokenAndNavigate {
  static Future<bool> setUserLoggedIn({
    String? token,
  }) async {
    bool save = true;
    if (token != null || token!.isNotEmpty) {
      final storageServices = getIt<StorageServices>();
      // Save the token in the sharedprefs..
      save = await storageServices.setString(
          AppConstants.STORAGE_USER_TOKEN_KEY,
          token); // List<String> myStrings = ['apple', 'banana', 'cherry'];  String result2 = myStrings.join('');   print(result2); // Output: applebananacherry
    }

    if (save) return true;
    return false;
  }
}
