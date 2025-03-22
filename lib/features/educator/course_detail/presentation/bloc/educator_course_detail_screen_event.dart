part of 'educator_course_detail_screen_bloc.dart';

@immutable
sealed class EducatorCourseDetailScreenEvent {}

final class GetEducatorCourseSections extends EducatorCourseDetailScreenEvent {
  final CourseVideoRequestEntity req;
  GetEducatorCourseSections({required this.req});
}
