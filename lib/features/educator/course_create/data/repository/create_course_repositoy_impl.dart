import 'package:assam_edu/features/educator/course_create/data/data_resources/create_course_remote_data_source.dart';
import 'package:assam_edu/features/educator/course_create/domain/repository/create_course_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/create_course.dart';
import '../model/create_course_mapper.dart';

class CreateCourseRepositoyImpl implements CreateCourseRepository {
  final CreateCourseRemoteDataSource courseRemoteDataSource;

  CreateCourseRepositoyImpl({required this.courseRemoteDataSource});

  @override
  Future<Either<Failure, CourseCreateResponseEntity>> uploadCourse(
      {required CourseCreateRequestEntity course}) async {
    try {
      // converting domain entity to data model
      final requestModel = CreateCourseMapper.toCourseModel(req: course);
      final responseModel =
          await courseRemoteDataSource.createCourse(user: requestModel);
      // Convert data model back to domain entity
      final responseEntity =
          CreateCourseMapper.toCourseEntity(res: responseModel);
      return right(responseEntity);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
