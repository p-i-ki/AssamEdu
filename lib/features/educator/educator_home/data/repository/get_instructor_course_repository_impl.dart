import 'package:assam_edu/core/error/failure.dart';
import 'package:assam_edu/features/educator/educator_home/domain/entity/instructor_course_entity.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../../core/error/exceptions.dart';
import '../../domain/repository/get_instructor_course_repository.dart';
import '../data_resource/get_instructor_course_remote_data_source.dart';
import '../model/instructor_course_mapper.dart';

class GetInstructorCourseRepositoryImpl
    implements GetInstructorCourseRepository {
  final GetInstructorCourseRemoteDataSource getInstructorCourseRemoteDataSource;
  GetInstructorCourseRepositoryImpl(this.getInstructorCourseRemoteDataSource);
  @override
  Future<Either<Failure, InstructorCourseResEntity>> getCourses() async {
    try {
      final responseModel =
          await getInstructorCourseRemoteDataSource.getCourses();
      final responseEntity =
          InstructorCourseMapper.toInstructorResEntity(res: responseModel);
      return right(responseEntity);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
