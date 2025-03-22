import 'package:assam_edu/core/error/exceptions.dart';
import 'package:assam_edu/core/error/failure.dart';
import 'package:assam_edu/features/educator/add_sections/data/data%20source/add_section_remote_data_source.dart';
import 'package:assam_edu/features/educator/add_sections/data/model/add_section_mapper.dart';
import 'package:assam_edu/features/educator/add_sections/domain/entity/add_section.dart';
import 'package:assam_edu/features/educator/add_sections/domain/repository/add_section_repository.dart';
import 'package:fpdart/fpdart.dart';

class AddSectionRepositoryImpl implements AddSectionRepository {
  final AddSectionRemoteDataSource addSectionRemoteDataSource;

  AddSectionRepositoryImpl({required this.addSectionRemoteDataSource});

  @override
  Future<Either<Failure, AddSectionNameResEntity>> uploadSectionName(
      {required AddSectionNameReqEntity req}) async {
    try {
      // converting domain entity to data model
      final requestModel = AddSectionMapper.toAddSecNameModel(req);
      final responseModel =
          await addSectionRemoteDataSource.uploadSectionName(req: requestModel);
      // Convert data model back to domain entity
      final responseEntity = AddSectionMapper.toAddSecNameEntity(responseModel);
      return right(responseEntity);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, AddSectionVideoResEntity>> uploadSectionVideo(
      {required AddSectionVideoReqEntity req}) async {
    try {
      // converting domain entity to data model
      final requestModel = AddSectionMapper.toAddSecVideoModel(req);
      final responseModel = await addSectionRemoteDataSource.uploadSectionVideo(
          req: requestModel);
      // Convert data model back to domain entity
      final responseEntity =
          AddSectionMapper.toAddSecVideoEntity(responseModel);
      return right(responseEntity);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
