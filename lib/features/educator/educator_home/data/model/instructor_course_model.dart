import '../../domain/entity/instructor_course_entity.dart';

class InstructorCourseResModel extends InstructorCourseResEntity {
  InstructorCourseResModel({
    required super.success,
    required super.message,
    required super.courses,
  });

  factory InstructorCourseResModel.fromJson(Map<String, dynamic> json) =>
      InstructorCourseResModel(
        success: json["success"],
        message: json["message"],
        courses: List<Course>.from(
            json["courses"].map((x) => CourseModel.fromJson(x))),
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
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        instructorId: json["instructorId"],
      );
}
