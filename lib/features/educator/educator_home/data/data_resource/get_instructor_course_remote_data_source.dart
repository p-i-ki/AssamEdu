import 'package:assam_edu/features/educator/educator_home/data/model/instructor_course_model.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/api/http_util.dart';

abstract interface class GetInstructorCourseRemoteDataSource {
  Future<InstructorCourseResModel> getCourses();
}

class GetInstructorCourseRemoteDataSourceImpl
    implements GetInstructorCourseRemoteDataSource {
  final HttpUtil httpUtil;
  GetInstructorCourseRemoteDataSourceImpl({required this.httpUtil});
  @override
  Future<InstructorCourseResModel> getCourses() async {
    try {
      final res =
          await httpUtil.get(path: '/api/instructor/getInstructorCourses');
      // print("Response from DATA Layer ----> $res");
      return InstructorCourseResModel.fromJson(res);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
