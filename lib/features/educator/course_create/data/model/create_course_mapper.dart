import 'package:assam_edu/features/educator/course_create/data/model/create_course_model.dart';
import 'package:assam_edu/features/educator/course_create/domain/entities/create_course.dart';

class CreateCourseMapper {
  static CourseCreateRequestModel toCourseModel(
      {required CourseCreateRequestEntity req}) {
    return CourseCreateRequestModel(
      title: req.title,
      description: req.description,
      category: req.category,
      tags: req.tags,
      thumbnail: req.thumbnail,
      price: req.price,
    );
  }

  static CourseCreateResponseEntity toCourseEntity(
      {required CourseCreateResponseModel res}) {
    return CourseCreateResponseEntity(
      success: res.success,
      message: res.message,
      course: res.course,
    );
  }
}
