import 'package:assam_edu/core/error/exceptions.dart';
import 'package:assam_edu/core/error/failure.dart';
import 'package:assam_edu/features/student/data/data_resources/get_course_remote_data_source.dart';
import 'package:assam_edu/features/student/data/models/course_mapper.dart';
import 'package:assam_edu/features/student/domain/entity/course.dart';
import 'package:assam_edu/features/student/domain/repository/get_course_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCourseRepositoryImpl implements GetCourseRepository {
  final GetCourseRemoteDataSource getCourseRemoteDataSouce;

  GetCourseRepositoryImpl({required this.getCourseRemoteDataSouce});

  @override
  Future<Either<Failure, CourseListResponseEntity>> getAllCourses(
      {required CourseListRequestEntity courseReq}) async {
    try {
      // converting domain entity to data model
      final requestModel = CourseMapper.toModel(courseReq);
      final responseModel =
          await getCourseRemoteDataSouce.getAllCourses(courseReq: requestModel);
      // Convert data model back to domain entity
      final responseEntity = CourseMapper.toEntity(responseModel);
      return right(responseEntity);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

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
