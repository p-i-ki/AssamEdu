import 'package:assam_edu/core/utlis/http_util.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../init_dependencies.dart';
import '../app_constants/app_constants.dart';
import '../config/google_sign_in_config.dart';
import '../storage_service/storage_service.dart';

class GoogleApi {
  static Future<bool> signIn(HttpUtil httpUtil) async {
    final GoogleSignInAccount? user = await GoogleSigninApi.logIn();
    final sv = getIt<StorageServices>();
    final userType = sv.getUserType();
    if (user == null) {
      return false;
    }

    debugPrint("User : $user");

    final GoogleSignInAuthentication googleAuth = await user.authentication;
    final String? idToken = googleAuth.idToken;
    debugPrint("Id Token from google-------: $idToken");

    if (idToken == null) {
      return false;
    }

    try {
      // Send ID Token to backend
      if (kDebugMode) {
        debugPrint("Http Request is made!");
      }

      final res = await httpUtil.post('/api/auth/google', myData: {
        'idToken': idToken,
        'role': userType,
      });

      if (kDebugMode) {
        debugPrint("-----Response in Google API----- : $res");

        debugPrint("------- res.data['success'] ------: ${res['success']}");
      }

      if (res['success'] == true) {
        await sv.deleteSharedPrefValue(AppConstants.STORAGE_USER_TOKEN_KEY);

        final jwtToken = res['token'];

        if (kDebugMode) {
          debugPrint("JWT From backend: $jwtToken");
        }

        // Save the token in the sharedprefs..
        final save =
            await sv.setString(AppConstants.STORAGE_USER_TOKEN_KEY, jwtToken);
        await sv.setString(AppConstants.SIGN_IN_TYPE, 'google_sign_in');
        if (save) return true;
        return false;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
