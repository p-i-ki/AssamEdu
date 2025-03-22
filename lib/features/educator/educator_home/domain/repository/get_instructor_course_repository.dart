import 'package:assam_edu/core/error/failure.dart';
import 'package:assam_edu/features/educator/educator_home/domain/entity/instructor_course_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class GetInstructorCourseRepository {
  Future<Either<Failure, InstructorCourseResEntity>> getCourses();
}
