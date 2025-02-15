import 'package:assam_edu/core/app_constants/app_constants.dart';
import 'package:assam_edu/core/error/exceptions.dart';
import 'package:assam_edu/core/utlis/http_util.dart';
import 'package:assam_edu/features/student/data/models/course_model.dart';
import 'package:dio/dio.dart';

abstract interface class GetCourseRemoteDataSource {
  Future<CourseListResponseModel> getAllCourses(
      {required CourseListRequestModel courseReq});
}

class GetCourseRemoteDataSourceImpl implements GetCourseRemoteDataSource {
  final HttpUtil httpUtil;
  GetCourseRemoteDataSourceImpl({required this.httpUtil});
  @override
  Future<CourseListResponseModel> getAllCourses(
      {required CourseListRequestModel courseReq}) async {
    try {
      final res = await httpUtil.get(
          path: '/api/getAllCourses',
          options: Options(
              headers: {AppConstants.STORAGE_USER_TOKEN_KEY: courseReq.token}));
      print("Response from DATA Layer ----> $res");
      return CourseListResponseModel.fromMap(res);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
