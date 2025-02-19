import 'package:assam_edu/core/error/failure.dart';
import 'package:assam_edu/features/student/domain/entity/course.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class GetCourseRepository {
  Future<Either<Failure, CourseListResponseEntity>> getAllCourses(
      {required CourseListRequestEntity courseReq});

  Future<Either<Failure, CourseVideoResponseEntity>> getCourseVideos(
      {required CourseVideoRequestEntity courseReq});
}
