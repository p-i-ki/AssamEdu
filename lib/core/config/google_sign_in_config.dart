import 'package:google_sign_in/google_sign_in.dart';

class GoogleSigninApi {
  static final _googleSignIn = GoogleSignIn(
      serverClientId:
          '661902661573-0fnua6e0f5ik8va4678lge99eod0h7s3.apps.googleusercontent.com',
      scopes: ['email']);

  static Future<GoogleSignInAccount?> logIn() => _googleSignIn.signIn();

  static Future logOut() => _googleSignIn.disconnect();
}
