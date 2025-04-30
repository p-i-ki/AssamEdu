import 'package:assam_edu/features/educator/profile/data/models/educator_profile_model.dart';

import '../../domain/entities/educator_profile.dart';

class CreateEducatorProfileMapper {
  static EducatorProfileCreateReqModel toProfileModel(
      {required EducatorProfileCreateReqEntity req}) {
    return EducatorProfileCreateReqModel(
      bio: req.bio,
      qualification: req.qualification,
      profilePicture: req.profilePicture,
    );
  }

  static EducatorProfileCreateResEntity toProfileEntity(
      {required EducatorProfileCreateResModel res}) {
    return EducatorProfileCreateResEntity(
      success: res.success,
      message: res.message,
      profile: res.profile,
    );
  }
}
