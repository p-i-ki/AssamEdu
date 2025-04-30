import 'dart:io';

import 'package:assam_edu/core/error/failure.dart';
import 'package:assam_edu/core/use_case/use_case.dart';
import 'package:assam_edu/features/educator/profile/domain/entities/educator_profile.dart';
import 'package:assam_edu/features/educator/profile/domain/repositories/create_educator_profile_repository.dart';
import 'package:fpdart/fpdart.dart';

class CreateEducatorProfile
    implements UseCase<EducatorProfileCreateResEntity, CreateProfileParams> {
  final CreateEducatorProfileRepository createEducatorProfileRepository;

  CreateEducatorProfile({required this.createEducatorProfileRepository});

  @override
  Future<Either<Failure, EducatorProfileCreateResEntity>> call(
      CreateProfileParams params) async {
    final req = EducatorProfileCreateReqEntity(
      bio: params.bio,
      qualification: params.qualification,
      profilePicture: params.profilePicture,
    );
    return await createEducatorProfileRepository.createProfile(req: req);
  }
}

class CreateProfileParams {
  String bio;
  String qualification;
  File profilePicture;

  CreateProfileParams({
    required this.bio,
    required this.profilePicture,
    required this.qualification,
  });
}
