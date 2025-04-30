// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

class EducatorProfileCreateReqEntity {
  String bio;
  String qualification;
  File profilePicture;
  EducatorProfileCreateReqEntity({
    required this.bio,
    required this.qualification,
    required this.profilePicture,
  });
}

class EducatorProfileCreateResEntity {
  final bool success;
  final String message;
  final Profile profile;

  EducatorProfileCreateResEntity({
    required this.success,
    required this.message,
    required this.profile,
  });
}

class Profile {
  String instructorId;
  String bio;
  String qualification;
  String profilePicture;
  DateTime updatedAt;
  DateTime createdAt;
  String userId;

  Profile({
    required this.instructorId,
    required this.bio,
    required this.qualification,
    required this.profilePicture,
    required this.updatedAt,
    required this.createdAt,
    required this.userId,
  });
}
