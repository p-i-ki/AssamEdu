import 'package:assam_edu/core/error/exceptions.dart';
import 'package:assam_edu/core/utlis/http_util.dart';
import 'package:assam_edu/features/educator/course_create/data/model/create_course_model.dart';

abstract interface class CreateCourseRemoteDataSource {
  // Session? get currentUserSession;
  Future<CourseCreateResponseModel> createCourse(
      {required CourseCreateRequestModel user});
}

class CreateCourseRemoteDataSourceImpl implements CreateCourseRemoteDataSource {
  final HttpUtil httpUtil;

  CreateCourseRemoteDataSourceImpl({required this.httpUtil});

  @override
  Future<CourseCreateResponseModel> createCourse(
      {required CourseCreateRequestModel user}) async {
    try {
      final res = await httpUtil.post('/api/instructor/createcourse',
          myData: user.toFormData());
      print("Response from DATA Layer ----> $res");
      return CourseCreateResponseModel.fromJson(res);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
