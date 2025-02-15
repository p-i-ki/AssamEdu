import 'package:assam_edu/core/error/failure.dart';
import 'package:assam_edu/core/use_case/use_case.dart';
import 'package:assam_edu/features/course/course_create/domain/entities/create_course.dart';
import 'package:assam_edu/features/course/course_create/domain/repository/create_course_repository.dart';
import 'package:fpdart/fpdart.dart';

class CreateCourse
    implements UseCase<CreateCourseResponseEntity, CreateCourseParams> {
  final CreateCourseRepository createCourseRepository;
  CreateCourse(this.createCourseRepository);
  @override
  Future<Either<Failure, CreateCourseResponseEntity>> call(
      CreateCourseParams params) async {
    final course = CreateCourseRequestEntity(
      courseName: params.courseName,
      description: params.description,
      price: params.price,
      thumbnailPath: params.thumbnailPath,
      chapters: params.chapters,
      demoMaterials: params.demoMaterials,
    );
    return await createCourseRepository.uploadCourse(course: course);
  }
}

class CreateCourseParams {
  final String courseName;
  final String description;
  final String price;
  final String thumbnailPath;
  final List<Chapter> chapters;
  final List<DemoMaterial> demoMaterials;

  CreateCourseParams({
    required this.courseName,
    required this.description,
    required this.price,
    required this.thumbnailPath,
    required this.chapters,
    required this.demoMaterials,
  });
}

// class Chapter {
//   final String title;
//   final String type;
//   final String uploadPath;
//   final String description;

//   Chapter({
//     required this.title,
//     required this.type,
//     required this.uploadPath,
//     required this.description,
//   });
// }

// class DemoMaterial {
//   final String title;
//   final String type;
//   final String uploadPath;
//   final String description;

//   DemoMaterial({
//     required this.title,
//     required this.type,
//     required this.uploadPath,
//     required this.description,
//   });
// }
