import 'package:assam_edu/core/error/exceptions.dart';
import 'package:assam_edu/core/api/http_util.dart';
import 'package:assam_edu/features/educator/add_sections/data/model/add_section_model.dart';

abstract interface class AddSectionRemoteDataSource {
  Future<AddSectionNameResModel> uploadSectionName(
      {required AddSectionNameReqModel req});

  Future<AddSectionVideoResModel> uploadSectionVideo(
      {required AddSectionVideoReqModel req});
}

class AddSectionRemoteDataSourceImpl implements AddSectionRemoteDataSource {
  final HttpUtil httpUtil;

  AddSectionRemoteDataSourceImpl({required this.httpUtil});

  @override
  Future<AddSectionNameResModel> uploadSectionName(
      {required AddSectionNameReqModel req}) async {
    try {
      // Add Compute Method here for isolates
      final res = await httpUtil.post(
          '/api/instructor/${req.courseId}/addSection',
          myData: req.toMap());
      print("Response from DATA Layer ----> $res");
      return AddSectionNameResModel.fromJson(res);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<AddSectionVideoResModel> uploadSectionVideo(
      {required AddSectionVideoReqModel req}) async {
    try {
      // Add Compute Method here for isolates
      final res = await httpUtil.post(
          '/api/instructor/${req.courseId}/${req.sectionId}/uploads/video',
          myData: req.toFormData());
      print("Response from DATA Layer ----> $res");
      return AddSectionVideoResModel.fromJson(res);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
