import 'package:assam_edu/core/error/failure.dart';
import 'package:assam_edu/core/use_case/use_case.dart';
import 'package:assam_edu/features/educator/educator_home/domain/entity/instructor_course_entity.dart';
import 'package:assam_edu/features/educator/educator_home/domain/repository/get_instructor_course_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetInstructorCourses
    implements UseCase<InstructorCourseResEntity, NoParams> {
  final GetInstructorCourseRepository getInstructorCourseRepository;
  GetInstructorCourses({required this.getInstructorCourseRepository});

  @override
  Future<Either<Failure, InstructorCourseResEntity>> call(
      NoParams params) async {
    return await getInstructorCourseRepository.getCourses();
  }
}

class NoParams {}
