import 'package:assam_edu/core/error/exceptions.dart';
import 'package:assam_edu/core/api/http_util.dart';
import 'package:assam_edu/core/model/course_model.dart';

abstract interface class CourseSectionRemoteDataSource {
  Future<CourseVideoResponseModel> getCourseVideos(
      {required CourseVideoRequestModel courseReq});
}

class CourseSectionRemoteDataSourceImpl
    implements CourseSectionRemoteDataSource {
  final HttpUtil httpUtil;
  CourseSectionRemoteDataSourceImpl({required this.httpUtil});

  @override
  Future<CourseVideoResponseModel> getCourseVideos(
      {required CourseVideoRequestModel courseReq}) async {
    try {
      final res = await httpUtil.get(
        path: '/api/courses/${courseReq.courseId}',
      );
      print("Response from DATA Layer ----> $res");
      return CourseVideoResponseModel.fromJson(res);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
