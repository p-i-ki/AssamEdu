import 'package:assam_edu/features/student/data/models/course_model.dart';
import 'package:assam_edu/features/student/domain/entity/course.dart';

class CourseMapper {
  static CourseListRequestModel toModel(CourseListRequestEntity entity) {
    return CourseListRequestModel(token: entity.token);
  }

  static CourseListResponseEntity toEntity(CourseListResponseModel model) {
    return CourseListResponseEntity(
      success: model.success,
      courseItems: model.courseItems,
    );
  }

  static CourseVideoRequestModel toVideoRequestModel(
      CourseVideoRequestEntity entity) {
    return CourseVideoRequestModel(courseId: entity.courseId);
  }

  static CourseVideoResponseEntity toVideoResponseEntity(
      CourseVideoResponseModel model) {
    return CourseVideoResponseEntity(
      success: model.success,
      course: model.course,
    );
  }
}
