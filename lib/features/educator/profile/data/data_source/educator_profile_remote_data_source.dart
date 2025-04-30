import 'package:assam_edu/features/educator/profile/data/models/educator_profile_model.dart';
import 'package:flutter/material.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/utlis/http_util.dart';

abstract interface class EducatorProfileRemoteDataSource {
  Future<EducatorProfileCreateResModel> createProfile(
      {required EducatorProfileCreateReqModel req});
}

class EducatorProfileRemoteDataSourceImpl
    implements EducatorProfileRemoteDataSource {
  final HttpUtil httpUtil;

  EducatorProfileRemoteDataSourceImpl({required this.httpUtil});

  @override
  Future<EducatorProfileCreateResModel> createProfile(
      {required EducatorProfileCreateReqModel req}) async {
    try {
      final res = await httpUtil.post('/api/instructor/addProfile',
          myData: req.toFormData());
      debugPrint("Response from DATA Layer ----> $res");
      return EducatorProfileCreateResModel.fromJson(res);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
