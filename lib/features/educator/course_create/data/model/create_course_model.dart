import 'package:assam_edu/features/educator/course_create/domain/entities/create_course.dart';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart'; // Import http_parser

class CourseCreateRequestModel extends CourseCreateRequestEntity {
  CourseCreateRequestModel({
    required super.title,
    required super.description,
    required super.category,
    required super.tags,
    required super.thumbnail,
    required super.price,
  });

  FormData toFormData() {
    String? mimeType = lookupMimeType(thumbnail.path); // Get mimetype
    return FormData.fromMap({
      "title": title,
      "description": description,
      "category": category,
      "tags": tags,
      "thumbnail": MultipartFile.fromFileSync(
        thumbnail.path,
        filename: thumbnail.path.split('/').last,
        contentType:
            mimeType != null ? MediaType.parse(mimeType) : null, // Set mimetype
      ),
      "price": price,
    });
  }
}

class CourseCreateResponseModel extends CourseCreateResponseEntity {
  CourseCreateResponseModel({
    required super.success,
    required super.message,
    required super.course,
  });

  factory CourseCreateResponseModel.fromJson(Map<String, dynamic> json) =>
      CourseCreateResponseModel(
        success: json["success"] as bool? ?? false,
        message: json["message"] as String? ?? "",
        course: json["course"] != null
            ? CourseModel.fromJson(json["course"])
            : throw Exception(json["message"]),
      );

  // Map<String, dynamic> toJson() => {
  //   "success":success,
  //     "message": message,
  //     "course": course.toJson(),
  // };
}

class CourseModel extends Course {
  CourseModel({
    required super.courseId,
    required super.title,
    required super.description,
    required super.price,
    required super.thumbnailUrl,
    required super.updatedAt,
    required super.createdAt,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        courseId: json["courseId"] ?? "",
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        price: json["price"] ?? "",
        thumbnailUrl: json["thumbnailUrl"] ?? "",
        updatedAt: json["updatedAt"] != null
            ? DateTime.tryParse(json["updatedAt"]) ?? DateTime.now()
            : DateTime.now(), // Default to current time if null
        createdAt: json["createdAt"] != null
            ? DateTime.tryParse(json["createdAt"]) ?? DateTime.now()
            : DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        "courseId": courseId,
        "title": title,
        "description": description,
        "price": price,
        "thumbnailUrl": thumbnailUrl,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
      };
}
