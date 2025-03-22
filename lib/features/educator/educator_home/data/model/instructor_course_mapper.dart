import 'package:assam_edu/features/educator/educator_home/data/model/instructor_course_model.dart';
import 'package:assam_edu/features/educator/educator_home/domain/entity/instructor_course_entity.dart';

class InstructorCourseMapper {
  static InstructorCourseResEntity toInstructorResEntity(
      {required InstructorCourseResModel res}) {
    return InstructorCourseResEntity(
      success: res.success,
      message: res.message,
      courses: res.courses,
    );
  }
}
