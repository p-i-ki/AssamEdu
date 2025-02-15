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
