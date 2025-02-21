// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';

import 'package:assam_edu/core/error/failure.dart';
import 'package:assam_edu/core/use_case/use_case.dart';
import 'package:assam_edu/core/entities/course.dart';
import 'package:assam_edu/features/student/student_home/domain/repository/get_course_repository.dart';

class GetAllCourses
    implements UseCase<CourseListResponseEntity, GetAllCourseParams> {
  GetCourseRepository getCourseRepository;
  GetAllCourses(this.getCourseRepository);
  @override
  Future<Either<Failure, CourseListResponseEntity>> call(
      GetAllCourseParams params) {
    final courseReq = CourseListRequestEntity(token: params.token);
    return getCourseRepository.getAllCourses(courseReq: courseReq);
  }
}

class GetAllCourseParams {
  String? token;
  GetAllCourseParams({
    required this.token,
  });
}
