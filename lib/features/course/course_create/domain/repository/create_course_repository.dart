import 'package:assam_edu/core/error/failure.dart';
import 'package:assam_edu/features/course/course_create/domain/entities/create_course.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CreateCourseRepository {
  Future<Either<Failure, CreateCourseResponseEntity>> uploadCourse(
      {required CreateCourseRequestEntity course});
}
