import 'dart:convert';

import 'package:assam_edu/features/student/domain/entity/course.dart'; // Import your entities

class CourseListRequestModel extends CourseListRequestEntity {
  CourseListRequestModel({required super.token});

  Map<String, dynamic> toMap() {
    return {'token': token};
  }

  String toJson() => json.encode(toMap());
}

class CourseListResponseModel extends CourseListResponseEntity {
  CourseListResponseModel({
    required super.success,
    required super.courseItems, // Changed to 'courses' (plural) and List<CourseItem>
  });

  factory CourseListResponseModel.fromMap(Map<String, dynamic> map) {
    return CourseListResponseModel(
      success: map['success'] ?? false,
      courseItems: (map['courses'] as List<dynamic>)
          .map((course) => CourseItemModel.fromJson(course))
          .toList(),
    );
  }
}

class CourseItemModel extends CourseItem {
  CourseItemModel({
    super.courseId,
    super.title,
    super.category, // Corrected typo: categrory -> category
    super.description,
    super.tags,
    super.price,
    super.thumbnailUrl,
    super.createdAt,
    super.updatedAt,
    super.instructorId,
  });

  factory CourseItemModel.fromJson(Map<String, dynamic> course) =>
      CourseItemModel(
        courseId:
            course['courseId']?.toString() ?? "", // Handle potential int/String
        title: course['title'] ?? "",
        category: course['category'] ?? "", // Corrected typo
        description: course['description'] ?? "",
        tags: course['tags'] ?? "",
        price: course['price']?.toString() ?? "", // Handle potential int/String
        thumbnailUrl: course['thumbnailUrl'] ?? "",
        createdAt: course['createdAt'] != null
            ? DateTime.parse(course['createdAt'])
            : null,
        updatedAt: course['updatedAt'] != null
            ? DateTime.parse(course['updatedAt'])
            : null,
        instructorId: course['instructorId']?.toString() ??
            "", // Handle potential int/String
      );
}

class CourseVideoRequestModel extends CourseVideoRequestEntity {
  CourseVideoRequestModel({required super.courseId});
  Map<String, dynamic> toMap() {
    return {'courseId': courseId};
  }

  String toJson() => json.encode(toMap());
}

class CourseVideoResponseModel extends CourseVideoResponseEntity {
  CourseVideoResponseModel({required super.success, required super.course});
  factory CourseVideoResponseModel.fromJson(Map<String, dynamic> json) =>
      CourseVideoResponseModel(
        success: json["success"],
        course: CourseModel.fromJson(json["course"]),
      );

  // Map<String, dynamic> toJson() => {
  //       "message": success,
  //       "course": course.toJson(),
  //     };
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
    required super.sections,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        courseId: json["courseId"] ?? "",
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        price: json["price"] ?? 0,
        thumbnailUrl: json["thumbnailUrl"] ?? "",
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        instructorId: json["instructorId"],
        sections: List<Section>.from(
            json["sections"].map((x) => SectionModel.fromJson(x))),
      );

  // Map<String, dynamic> toJson() => {
  //     "courseId": courseId,
  //     "title": title,
  //     "description": description,
  //     "price": price,
  //     "thumbnailUrl": thumbnailUrl,
  //     "createdAt": createdAt.toIso8601String(),
  //     "updatedAt": updatedAt.toIso8601String(),
  //     "instructorId": instructorId,
  //     "sections": List<dynamic>.from(sections.map((x) => x.toJson())),
  // };
}

class SectionModel extends Section {
  SectionModel({
    required super.sectionId,
    required super.sectionName,
    required super.createdAt,
    required super.updatedAt,
    required super.courseId,
    required super.videos,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) => SectionModel(
        sectionId: json["sectionId"],
        sectionName: json["sectionName"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        courseId: json["courseId"],
        videos:
            List<Video>.from(json["videos"].map((x) => VideoModel.fromJson(x))),
      );

  // Map<String, dynamic> toJson() => {
  //     "sectionId": sectionId,
  //     "sectionName": sectionName,
  //     "createdAt": createdAt.toIso8601String(),
  //     "updatedAt": updatedAt.toIso8601String(),
  //     "courseId": courseId,
  //     "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
  // };
}

class VideoModel extends Video {
  VideoModel({
    required super.videoId,
    required super.title,
    required super.url,
    required super.captionUrl,
    required super.notes,
    required super.createdAt,
    required super.updatedAt,
    required super.sectionId,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        videoId: json["videoId"],
        title: json["title"],
        url: json["url"],
        captionUrl: json["captionUrl"],
        notes: json["notes"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        sectionId: json["sectionId"],
      );

//     Map<String, dynamic> toJson() => {
//         "videoId": videoId,
//         "title": title,
//         "url": url,
//         "captionUrl": captionUrl,
//         "notes": notes,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "sectionId": sectionId,
//     };
// }
}
