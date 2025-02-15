// ignore_for_file: public_member_api_docs, sort_constructors_first
class CourseListRequestEntity {
  String? token;
  CourseListRequestEntity({required this.token});
}

class CourseListResponseEntity {
  bool? success;
  List<CourseItem>? courseItems;
  CourseListResponseEntity({
    this.success,
    this.courseItems,
  });
}

class CourseItem {
  String? courseId; // Changed to String?
  String? title;
  String? description;
  String? category;
  String? tags;
  String? price; // Changed to String?
  String? thumbnailUrl;
  DateTime? createdAt; // Added createdAt
  DateTime? updatedAt; // Added updatedAt
  String? instructorId; // Added instructorId

  CourseItem({
    this.courseId,
    this.title,
    this.description,
    this.category,
    this.tags,
    this.price,
    this.thumbnailUrl,
    this.createdAt,
    this.updatedAt,
    this.instructorId,
  });
}
