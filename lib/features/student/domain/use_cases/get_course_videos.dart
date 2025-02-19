import 'package:assam_edu/core/error/failure.dart';
import 'package:assam_edu/core/use_case/use_case.dart';
import 'package:assam_edu/features/student/domain/entity/course.dart';
import 'package:assam_edu/features/student/domain/repository/get_course_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCourseVideos
    implements UseCase<CourseVideoResponseEntity, GetCourseVideoParams> {
  GetCourseRepository getCourseRepository;
  GetCourseVideos(this.getCourseRepository);
  @override
  Future<Either<Failure, CourseVideoResponseEntity>> call(
      GetCourseVideoParams params) {
    final courseReq = CourseVideoRequestEntity(courseId: params.courseId);
    return getCourseRepository.getCourseVideos(courseReq: courseReq);
  }
}

class GetCourseVideoParams {
  String? courseId;
  GetCourseVideoParams({
    required this.courseId,
  });
}
