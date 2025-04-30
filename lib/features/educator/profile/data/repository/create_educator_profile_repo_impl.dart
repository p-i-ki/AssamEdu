import 'package:assam_edu/core/error/failure.dart';
import 'package:assam_edu/features/educator/profile/data/data_source/educator_profile_remote_data_source.dart';
import 'package:assam_edu/features/educator/profile/data/models/educator_profile_mapper.dart';

import 'package:assam_edu/features/educator/profile/domain/entities/educator_profile.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/error/exceptions.dart';
import '../../domain/repositories/create_educator_profile_repository.dart';

class CreateEducatorProfileRepoImpl implements CreateEducatorProfileRepository {
  final EducatorProfileRemoteDataSource educatorProfileRemoteDataSource;

  CreateEducatorProfileRepoImpl(
      {required this.educatorProfileRemoteDataSource});
  @override
  Future<Either<Failure, EducatorProfileCreateResEntity>> createProfile(
      {required EducatorProfileCreateReqEntity req}) async {
    try {
      // converting domain entity to data model
      final reqModel = CreateEducatorProfileMapper.toProfileModel(req: req);
      final resModel =
          await educatorProfileRemoteDataSource.createProfile(req: reqModel);
      // Convert data model back to domain entity
      final responseEntity =
          CreateEducatorProfileMapper.toProfileEntity(res: resModel);
      return right(responseEntity);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
