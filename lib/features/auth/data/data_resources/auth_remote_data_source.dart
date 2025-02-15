import 'package:assam_edu/core/error/exceptions.dart';
import 'package:assam_edu/core/utlis/http_util.dart';
import 'package:assam_edu/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  // Session? get currentUserSession;
  Future<UserSignUpResponseModel> signUpWithEmailPassword(
      {required UserSignUpRequestModel user});
  Future<UserSignInResponseModel> signInWithEmailPassword(
      {required UserSignInRequestModel user});

  Future<UserVerifyOtpResponseModel> verifyOtp(
      {required UserVerifyOtpRequestModel user});
  // Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // final httpUtil = getIt<HttpUtil>();
  final HttpUtil httpUtil;
  AuthRemoteDataSourceImpl({required this.httpUtil});

  @override
  Future<UserSignUpResponseModel> signUpWithEmailPassword(
      {required UserSignUpRequestModel user}) async {
    try {
      final res = await httpUtil.post('/api/register', myData: user.toMap());
      print("Response from DATA Layer ----> $res");
      return UserSignUpResponseModel.fromJson(res);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserSignInResponseModel> signInWithEmailPassword(
      {required UserSignInRequestModel user}) async {
    try {
      final res = await httpUtil.post('/api/login', myData: user.toMap());
      print("Response from DATA Layer ----> $res");
      return UserSignInResponseModel.fromJson(res);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserVerifyOtpResponseModel> verifyOtp(
      {required UserVerifyOtpRequestModel user}) async {
    try {
      final res = await httpUtil.post('/api/verify-otp', myData: user.toMap());
      print("Response from DATA Layer ----> $res");
      return UserVerifyOtpResponseModel.fromJson(res);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
