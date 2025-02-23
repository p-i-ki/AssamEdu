import 'dart:io';

import 'package:assam_edu/core/error/failure.dart';
import 'package:assam_edu/core/use_case/use_case.dart';
import 'package:assam_edu/features/educator/course_create/domain/entities/create_course.dart';
import 'package:assam_edu/features/educator/course_create/domain/repository/create_course_repository.dart';
import 'package:fpdart/fpdart.dart';

class CreateCourse
    implements UseCase<CourseCreateResponseEntity, CreateCourseParams> {
  final CreateCourseRepository createCourseRepository;
  CreateCourse(this.createCourseRepository);
  @override
  Future<Either<Failure, CourseCreateResponseEntity>> call(
      CreateCourseParams params) async {
    final course = CourseCreateRequestEntity(
      title: params.title,
      description: params.description,
      category: params.category,
      tags: params.tags,
      thumbnail: params.thumbnail,
      price: params.price,
    );
    return await createCourseRepository.uploadCourse(course: course);
  }
}

class CreateCourseParams {
  final String title;
  final String description;
  final String category;
  final String tags;
  final File thumbnail;
  final String price;

  CreateCourseParams({
    required this.title,
    required this.description,
    required this.category,
    required this.tags,
    required this.thumbnail,
    required this.price,
  });
}
