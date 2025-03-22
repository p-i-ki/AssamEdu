import 'package:assam_edu/features/educator/add_sections/domain/entity/add_section.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class AddSectionNameReqModel extends AddSectionNameReqEntity {
  AddSectionNameReqModel({
    required super.sectionName,
    required super.courseId,
  });

  Map<String, dynamic> toMap() {
    return {
      'sectionName': sectionName,
      // 'courseId': courseId,
    };
  }
}

class AddSectionNameResModel extends AddSectionNameResEntity {
  AddSectionNameResModel({
    required super.success,
    required super.message,
    required super.instructor,
    required super.course,
    required super.sections,
  });

  factory AddSectionNameResModel.fromJson(Map<String, dynamic> json) =>
      AddSectionNameResModel(
        success: json["success"],
        message: json["message"],
        instructor: json["instructor"] == null
            ? null
            : InstructorModel.fromJson(json["instructor"]),
        course: json["course"] == null
            ? null
            : CourseModel.fromJson(json["course"]),
        sections: json["sections"] == null
            ? []
            : List<Section>.from(
                json["sections"]!.map((x) => SectionModel.fromJson(x))),
      );
}

class InstructorModel extends Instructor {
  InstructorModel({
    required super.instructorId,
    required super.bio,
    required super.qualification,
    required super.profilePicture,
    required super.createdAt,
    required super.updatedAt,
    required super.userId,
  });

  factory InstructorModel.fromJson(Map<String, dynamic> json) =>
      InstructorModel(
        instructorId: json["instructorId"],
        bio: json["bio"],
        qualification: json["qualification"],
        profilePicture: json["profilePicture"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        userId: json["userId"],
      );
}

class CourseModel extends Course {
  CourseModel({
    required super.courseId,
    required super.title,
    required super.description,
    required super.price,
    required super.thumbnailUrl,
    required super.createdAt,
    required super.updatedAt,
    required super.instructorId,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        courseId: json["courseId"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        thumbnailUrl: json["thumbnailUrl"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        instructorId: json["instructorId"],
      );
}

class SectionModel extends Section {
  SectionModel({
    required super.sectionId,
    required super.sectionName,
    required super.createdAt,
    required super.updatedAt,
    required super.courseId,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) => SectionModel(
        sectionId: json["sectionId"],
        sectionName: json["sectionName"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        courseId: json["courseId"],
      );
}

class AddSectionVideoReqModel extends AddSectionVideoReqEntity {
  AddSectionVideoReqModel({
    required super.sectionId,
    required super.courseId,
    required super.video,
    required super.title,
  });

  FormData toFormData() {
    String? mimeType = lookupMimeType(video!.path); // Get mimetype
    return FormData.fromMap({
      "title": title,
      "video": MultipartFile.fromFileSync(
        video!.path,
        filename: video!.path.split('/').last,
        contentType:
            mimeType != null ? MediaType.parse(mimeType) : null, // Set mimetype
      ),
    });
  }
}

class AddSectionVideoResModel extends AddSectionVideoResEntity {
  AddSectionVideoResModel({
    required super.message,
    required super.video,
    required super.success,
  });

  factory AddSectionVideoResModel.fromJson(Map<String, dynamic> json) =>
      AddSectionVideoResModel(
        success: json["success"],
        message: json["message"],
        video:
            json["video"] == null ? null : VideoModel.fromJson(json["video"]),
      );
}

class VideoModel extends Video {
  VideoModel({
    required super.videoId,
    required super.title,
    required super.url,
    required super.updatedAt,
    required super.createdAt,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        videoId: json["videoId"],
        title: json["title"],
        url: json["url"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );
}
