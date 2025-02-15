class CreateCourseRequestEntity {
  final String courseName;
  final String description;
  final String price;
  final String thumbnailPath;
  final List<Chapter> chapters;
  final List<DemoMaterial> demoMaterials;

  CreateCourseRequestEntity({
    required this.courseName,
    required this.description,
    required this.price,
    required this.thumbnailPath,
    required this.chapters,
    required this.demoMaterials,
  });
}

class CreateCourseResponseEntity {
  int? code;
  String? msg;
  // Chapter? chapter;

  CreateCourseResponseEntity({
    this.code,
    this.msg,
    // this.chapter,
  });
}

class Chapter {
  final String title;
  final String type;
  final String uploadPath;
  final String description;

  Chapter({
    required this.title,
    required this.type,
    required this.uploadPath,
    required this.description,
  });

  // Map<String, dynamic> toJson() {
  //   return {
  //     'title': title,
  //     'type': type,
  //     'uploadPath': uploadPath,
  //     'description': description,
  //   };
  // }
}

class DemoMaterial {
  final String title;
  final String type;
  final String uploadPath;
  final String description;

  DemoMaterial({
    required this.title,
    required this.type,
    required this.uploadPath,
    required this.description,
  });

  // Map<String, dynamic> toJson() {
  //   return {
  //     'title': title,
  //     'type': type,
  //     'uploadPath': uploadPath,
  //     'description': description,
  //   };
  // }
}
