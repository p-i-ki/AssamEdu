part of 'home_page_bloc.dart';

@immutable
sealed class HomePageState {
  const HomePageState();
}

final class HomePageLoading extends HomePageState {}

final class HomePageInitial extends HomePageState {
  final int index;

  const HomePageInitial({
    this.index = 0,
  });

  HomePageInitial copyWith({
    int? index,
  }) {
    return HomePageInitial(
      index: index ?? this.index,
    );
  }
}

// Get All Courses

final class HomePageGetAllCoursesLoading extends HomePageState {}

final class HomePageGetAllCoursesSuccess extends HomePageState {
  final List<CourseItem> courses;
  const HomePageGetAllCoursesSuccess({required this.courses});
}

final class HomePageGetAllCoursesError extends HomePageState {
  final String error;

  const HomePageGetAllCoursesError({required this.error});
}

// Play Videos

final class CourseVideoFetchLoading extends HomePageState {}

final class CourseVideoFetchSuccess extends HomePageState {
  final Course responseEntity;

  const CourseVideoFetchSuccess({required this.responseEntity});
}

final class CourseVideoFetchError extends HomePageState {
  final String error;

  const CourseVideoFetchError({required this.error});
}
