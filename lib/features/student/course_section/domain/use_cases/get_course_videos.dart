import 'package:assam_edu/core/error/failure.dart';
import 'package:assam_edu/core/use_case/use_case.dart';
import 'package:assam_edu/core/entities/course.dart';
import 'package:assam_edu/features/student/course_section/domain/repository/course_section_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCourseVideos
    implements UseCase<CourseVideoResponseEntity, GetCourseVideoParams> {
  CourseSectionRepository courseSectionRepository;
  GetCourseVideos({required this.courseSectionRepository});
  @override
  Future<Either<Failure, CourseVideoResponseEntity>> call(
      GetCourseVideoParams params) {
    final courseReq = CourseVideoRequestEntity(courseId: params.courseId);
    return courseSectionRepository.getCourseVideos(courseReq: courseReq);
  }
}

class GetCourseVideoParams {
  String? courseId;
  GetCourseVideoParams({
    required this.courseId,
  });
}
