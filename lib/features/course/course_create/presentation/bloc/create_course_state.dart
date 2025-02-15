part of 'create_course_bloc.dart';

@immutable
sealed class CreateCourseState {}

final class CreateCourseInitial extends CreateCourseState {}

final class CreateCourseLoading extends CreateCourseState {}

final class CreateCourseSuccess extends CreateCourseState {
  final CreateCourseResponseEntity response;
  CreateCourseSuccess({required this.response});
}

final class CreateCourseError extends CreateCourseState {
  final String error;
  CreateCourseError({required this.error});
}
