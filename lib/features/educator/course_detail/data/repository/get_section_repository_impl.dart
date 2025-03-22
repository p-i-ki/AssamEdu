import 'package:fpdart/fpdart.dart';

import '../../../../../core/entities/course.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/model/course_mapper.dart';
import '../../domain/repository/get_sections_repository.dart';
import '../data_resources/get_sections_remote_data_source.dart';

class GetSectionRepositoryImpl implements GetSectionsRepository {
  final GetSectionsRemoteDataSource getSectionsRemoteDataSource;
  GetSectionRepositoryImpl({required this.getSectionsRemoteDataSource});

  @override
  Future<Either<Failure, CourseVideoResponseEntity>> getSections(
      {required CourseVideoRequestEntity req}) async {
    try {
      // converting domain entity to data model
      final requestModel = CourseMapper.toVideoRequestModel(req);
      final responseModel = await getSectionsRemoteDataSource.getCourseVideos(
          courseReq: requestModel);
      // Convert data model back to domain entity
      final responseEntity = CourseMapper.toVideoResponseEntity(responseModel);
      return right(responseEntity);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
