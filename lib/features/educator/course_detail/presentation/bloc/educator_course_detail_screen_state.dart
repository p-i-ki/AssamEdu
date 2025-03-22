part of 'educator_course_detail_screen_bloc.dart';

@immutable
sealed class EducatorCourseDetailScreenState {
  const EducatorCourseDetailScreenState();
}

final class EducatorCourseDetailScreenInitial
    extends EducatorCourseDetailScreenState {}

final class EducatorGetCourseSectionLoading
    extends EducatorCourseDetailScreenState {}

final class EducatorGetCourseSectionSuccess
    extends EducatorCourseDetailScreenState {
  final Course res;

  const EducatorGetCourseSectionSuccess({required this.res});
}

final class EducatorGetCourseSectionError
    extends EducatorCourseDetailScreenState {
  final String error;

  const EducatorGetCourseSectionError({required this.error});
}
