// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_course_bloc.dart';

@immutable
sealed class CreateCourseEvent {}

class AddCourse extends CreateCourseEvent {
  final CourseCreateRequestEntity course;
  AddCourse({required this.course});
}
