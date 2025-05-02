import 'package:assam_edu/core/api/http_util.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/model/course_model.dart';

abstract interface class GetSectionsRemoteDataSource {
  Future<CourseVideoResponseModel> getCourseVideos(
      {required CourseVideoRequestModel courseReq});
}

class GetSectionsRemoteDataSourceImpl implements GetSectionsRemoteDataSource {
  final HttpUtil httpUtil;

  GetSectionsRemoteDataSourceImpl({required this.httpUtil});

  @override
  Future<CourseVideoResponseModel> getCourseVideos(
      {required CourseVideoRequestModel courseReq}) async {
    try {
      final res = await httpUtil.get(
        path: '/api/instructor/courses/${courseReq.courseId}',
      );
      print("Response from DATA Layer ----> $res");
      return CourseVideoResponseModel.fromJson(res);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
