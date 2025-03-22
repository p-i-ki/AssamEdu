part of 'educator_home_screen_bloc.dart';

@immutable
sealed class EducatorHomeScreenState {}

final class EducatorHomeScreenInitial extends EducatorHomeScreenState {}

final class EducatorHomeScreenLoading extends EducatorHomeScreenState {}

final class EducatorGetCourseSuccess extends EducatorHomeScreenState {
  final InstructorCourseResEntity res;

  EducatorGetCourseSuccess({required this.res});
}

final class EducatorGetCourseError extends EducatorHomeScreenState {
  final String error;

  EducatorGetCourseError({required this.error});
}
