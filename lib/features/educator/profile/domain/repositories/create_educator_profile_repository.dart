import 'package:assam_edu/features/educator/profile/domain/entities/educator_profile.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/error/failure.dart';

abstract interface class CreateEducatorProfileRepository {
  Future<Either<Failure, EducatorProfileCreateResEntity>> createProfile(
      {required EducatorProfileCreateReqEntity req});
}
