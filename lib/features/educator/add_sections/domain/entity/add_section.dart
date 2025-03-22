// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

class AddSectionNameReqEntity {
  String sectionName;
  String courseId;
  AddSectionNameReqEntity({
    required this.sectionName,
    required this.courseId,
  });
}

class AddSectionNameResEntity {
  bool? success;
  String? message;
  Instructor? instructor;
  Course? course;
  List<Section>? sections;

  AddSectionNameResEntity({
    required this.success,
    required this.message,
    required this.instructor,
    required this.course,
    required this.sections,
  });
}

class Course {
  String? courseId;
  String? title;
  String? description;
  int? price;
  String? thumbnailUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? instructorId;
  Course({
    required this.courseId,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnailUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.instructorId,
  });
}

class Instructor {
  String? instructorId;
  String? bio;
  dynamic qualification;
  String? profilePicture;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userId;
  Instructor({
    required this.instructorId,
    required this.bio,
    required this.qualification,
    required this.profilePicture,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });
}

class Section {
  String? sectionId;
  String? sectionName;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? courseId;
  Section({
    required this.sectionId,
    required this.sectionName,
    required this.createdAt,
    required this.updatedAt,
    required this.courseId,
  });
}

class AddSectionVideoReqEntity {
  String? sectionId;
  String? courseId;
  File? video;
  String? title;

  AddSectionVideoReqEntity({
    required this.sectionId,
    required this.courseId,
    required this.video,
    required this.title,
  });
}

class AddSectionVideoResEntity {
  bool? success;
  String? message;
  Video? video;

  AddSectionVideoResEntity({
    required this.message,
    required this.video,
    required this.success,
  });
}

class Video {
  String? videoId;
  String? title;
  String? url;
  DateTime? updatedAt;
  DateTime? createdAt;

  Video({
    required this.videoId,
    required this.title,
    required this.url,
    required this.updatedAt,
    required this.createdAt,
  });
}
