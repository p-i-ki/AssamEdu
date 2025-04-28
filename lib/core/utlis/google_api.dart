import 'dart:convert';
import 'package:assam_edu/core/utlis/http_util.dart';
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
    final storageServices = getIt<StorageServices>();
    if (user == null) {
      return false;
    }

    print("User : $user");

    final GoogleSignInAuthentication googleAuth = await user.authentication;
    final String? idToken = googleAuth.idToken;
    print("Id Token from google-------: $idToken");

    if (idToken == null) {
      return false;
    }

    try {
      // Send ID Token to backend
      print("Http Request is made!");

      final res = await httpUtil.post('/api/auth/google', myData: {
        'idToken': idToken,
        'role': userType,
      });

      print("-----Response in Google API----- : $res");

      print("------- res.data['success'] ------: ${res['success']}");

      if (res['success'] == true) {
        // TODO:
        await storageServices
            .deleteSharedPrefValue(AppConstants.STORAGE_USER_TOKEN_KEY);
        // final data = jsonDecode(res.body);
        final jwtToken = res['token'];

        print("JWT From backend: $jwtToken");

        // Save the token in the sharedprefs..
        final save = await storageServices.setString(
            AppConstants.STORAGE_USER_TOKEN_KEY, jwtToken);
        await storageServices.setString(
            AppConstants.SIGN_IN_TYPE, 'google_sign_in');
        if (save) return true;
        return false;
      } else {
        // print("Backend error: ${res.body}");
        return false;
      }
    } catch (e) {
      //print("Exception during backend auth: $e");
      return false;
    }
  }
}
