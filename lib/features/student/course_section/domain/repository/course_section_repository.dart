import 'package:assam_edu/core/entities/course.dart';
import 'package:assam_edu/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CourseSectionRepository {
  Future<Either<Failure, CourseVideoResponseEntity>> getCourseVideos(
      {required CourseVideoRequestEntity courseReq});
}
