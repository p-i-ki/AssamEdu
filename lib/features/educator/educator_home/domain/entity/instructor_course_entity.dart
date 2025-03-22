class InstructorCourseResEntity {
  bool? success;
  String? message;
  List<Course>? courses;

  InstructorCourseResEntity({
    required this.success,
    required this.message,
    required this.courses,
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
