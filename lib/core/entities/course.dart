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

class CourseVideoRequestEntity {
  String? courseId;
  CourseVideoRequestEntity({required this.courseId});
}

class CourseVideoResponseEntity {
  bool? success;
  Course? course;
  CourseVideoResponseEntity({
    required this.success,
    required this.course,
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
  List<Section>? sections;

  Course({
    this.courseId,
    this.title,
    this.description,
    this.price,
    this.thumbnailUrl,
    this.createdAt,
    this.updatedAt,
    this.instructorId,
    this.sections,
  });
}

class Section {
  String? sectionId;
  String? sectionName;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? courseId;
  List<Video>? videos;

  Section({
    required this.sectionId,
    required this.sectionName,
    required this.createdAt,
    required this.updatedAt,
    required this.courseId,
    required this.videos,
  });
}

class Video {
  String? videoId;
  String? title;
  String? url;
  dynamic captionUrl;
  dynamic notes;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? sectionId;

  Video({
    required this.videoId,
    required this.title,
    required this.url,
    required this.captionUrl,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.sectionId,
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
