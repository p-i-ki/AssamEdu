import 'package:assam_edu/core/error/failure.dart';
import 'package:assam_edu/features/educator/course_create/domain/entities/create_course.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CreateCourseRepository {
  Future<Either<Failure, CourseCreateResponseEntity>> uploadCourse(
      {required CourseCreateRequestEntity course});
}
