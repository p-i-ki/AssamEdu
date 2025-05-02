import 'package:assam_edu/core/api/http_util.dart';
import 'package:flutter/foundation.dart';

class LogoutApi {
  static Future<bool> logout({required HttpUtil httpUtil}) async {
    try {
      final res = await httpUtil.post('/api/logout');
      if (kDebugMode) {
        debugPrint("--- Response During Logout: $res");
      }
      if (res['success'] == true) {
        return true;
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Exception During Logout: $e");
      }
      return false;
    }
  }
}
