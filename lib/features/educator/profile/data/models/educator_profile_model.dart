import 'package:assam_edu/features/educator/profile/domain/entities/educator_profile.dart';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class EducatorProfileCreateReqModel extends EducatorProfileCreateReqEntity {
  EducatorProfileCreateReqModel({
    required super.bio,
    required super.qualification,
    required super.profilePicture,
  });

  FormData toFormData() {
    String? mimeType = lookupMimeType(profilePicture.path);

    return FormData.fromMap({
      "bio": bio,
      "qualification": qualification,
      "profilePicture": MultipartFile.fromFileSync(
        profilePicture.path,
        filename: profilePicture.path.split('/').last,
        contentType: mimeType != null ? MediaType.parse(mimeType) : null,
      )
    });
  }
}

class EducatorProfileCreateResModel extends EducatorProfileCreateResEntity {
  EducatorProfileCreateResModel({
    required super.success,
    required super.message,
    required super.profile,
  });

  factory EducatorProfileCreateResModel.fromJson(Map<String, dynamic> json) =>
      EducatorProfileCreateResModel(
        success: json["success"] as bool? ?? false,
        message: json["message"] as String? ?? "",
        profile: json["profile"] != null
            ? ProfileModel.fromJson(json["profile"])
            : throw Exception("Educator profile is missing"),
      );
}

class ProfileModel extends Profile {
  ProfileModel({
    required super.instructorId,
    required super.bio,
    required super.qualification,
    required super.profilePicture,
    required super.updatedAt,
    required super.createdAt,
    required super.userId,
  });
  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        instructorId: json["instructorId"] ?? "",
        bio: json["bio"] ?? "",
        qualification: json["qualification"] ?? "",
        profilePicture: json["profilePicture"] ?? "",
        userId: json["userId"] ?? "",
        updatedAt: json["updatedAt"] != null
            ? DateTime.tryParse(json["updatedAt"]) ?? DateTime.now()
            : DateTime.now(), // Default to current time if null
        createdAt: json["createdAt"] != null
            ? DateTime.tryParse(json["createdAt"]) ?? DateTime.now()
            : DateTime.now(),
      );
}
