import 'package:assam_edu/core/error/exceptions.dart';
import 'package:assam_edu/core/api/http_util.dart';
import 'package:assam_edu/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserSignUpResponseModel> signUpWithEmailPassword(
      {required UserSignUpRequestModel user});
  Future<UserSignInResponseModel> signInWithEmailPassword(
      {required UserSignInRequestModel user});

  Future<UserVerifyOtpResponseModel> verifyOtp(
      {required UserVerifyOtpRequestModel user});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final HttpUtil httpUtil;
  AuthRemoteDataSourceImpl({required this.httpUtil});

  @override
  Future<UserSignUpResponseModel> signUpWithEmailPassword(
      {required UserSignUpRequestModel user}) async {
    try {
      final res = await httpUtil.post('/api/register', myData: user.toMap());
      debugPrint("Response from DATA Layer ----> $res");
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
      debugPrint("Response from DATA Layer ----> $res");
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
      debugPrint("Response from DATA Layer ----> $res");
      return UserVerifyOtpResponseModel.fromJson(res);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
