// ignore_for_file: constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  // ignore: non_constant_identifier_names
  static String SERVER_API_URL = '${dotenv.env['SERVER_API_URL_NEW']}';
  static const String STORAGE_DEVICE_OPEN_FIRST_TIME = 'device_first_open';
  static const String STORAGE_USER_TOKEN_KEY = 'x-auth-token';
  static const String STORAGE_USER_PROFILE_KEY = 'user-profile';
  static const String USER_TYPE = 'user_type';
  static const String SIGN_IN_TYPE = 'sign_in_type';
  static const double dHeight = 915;
  static const double dWidth = 412;
  static const double dRadius = 12;
}
