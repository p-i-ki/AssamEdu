import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSigninApi {
  static final _googleSignIn = GoogleSignIn(
      serverClientId: '${dotenv.env['GOOGLE_WEB_CLIENT_ID']}',
      scopes: ['email']);

  static Future<GoogleSignInAccount?> logIn() => _googleSignIn.signIn();

  static Future logOut() => _googleSignIn.disconnect();
}
