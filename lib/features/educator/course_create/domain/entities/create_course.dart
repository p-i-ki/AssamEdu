import 'dart:io';

class CourseCreateRequestEntity {
  final String title;
  final String description;
  final String category;
  final String tags;
  final File thumbnail;
  final String price;

  CourseCreateRequestEntity({
    required this.title,
    required this.description,
    required this.category,
    required this.tags,
    required this.thumbnail,
    required this.price,
  });
}

class CourseCreateResponseEntity {
  bool success;
  String message;
  Course course;
  CourseCreateResponseEntity({
    required this.success,
    required this.message,
    required this.course,
  });
}

class Course {
  String courseId;
  String title;
  String description;
  String price;
  String thumbnailUrl;
  DateTime updatedAt;
  DateTime createdAt;

  Course({
    required this.courseId,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnailUrl,
    required this.updatedAt,
    required this.createdAt,
  });
}
