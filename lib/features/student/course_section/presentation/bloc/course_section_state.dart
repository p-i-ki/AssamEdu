part of 'course_section_bloc.dart';

@immutable
sealed class CourseSectionState {
  const CourseSectionState();
}

final class CourseSectionInitial extends CourseSectionState {}

// Play Videos

final class CourseVideoFetchLoading extends CourseSectionState {}

final class CourseVideoFetchSuccess extends CourseSectionState {
  final Course responseEntity;

  const CourseVideoFetchSuccess({required this.responseEntity});
}

final class CourseVideoFetchError extends CourseSectionState {
  final String error;

  const CourseVideoFetchError({required this.error});
}
