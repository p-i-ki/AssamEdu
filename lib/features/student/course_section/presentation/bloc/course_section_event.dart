part of 'course_section_bloc.dart';

@immutable
sealed class CourseSectionEvent {
  const CourseSectionEvent();
}

class CourseVideoFetch extends CourseSectionEvent {
  final CourseVideoRequestEntity requestEntity;

  const CourseVideoFetch({required this.requestEntity});
}
