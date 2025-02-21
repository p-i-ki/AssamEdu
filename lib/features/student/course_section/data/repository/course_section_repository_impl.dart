import 'package:assam_edu/features/student/course_section/data/data_resources/course_section_remote_data_sources.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../../core/entities/course.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/model/course_mapper.dart';
import '../../domain/repository/course_section_repository.dart';

class CourseSectionRepositoryImpl implements CourseSectionRepository {
  final CourseSectionRemoteDataSource getCourseRemoteDataSouce;

  CourseSectionRepositoryImpl({required this.getCourseRemoteDataSouce});

  @override
  Future<Either<Failure, CourseVideoResponseEntity>> getCourseVideos(
      {required CourseVideoRequestEntity courseReq}) async {
    try {
      // converting domain entity to data model
      final requestModel = CourseMapper.toVideoRequestModel(courseReq);
      final responseModel = await getCourseRemoteDataSouce.getCourseVideos(
          courseReq: requestModel);
      // Convert data model back to domain entity
      final responseEntity = CourseMapper.toVideoResponseEntity(responseModel);
      return right(responseEntity);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
