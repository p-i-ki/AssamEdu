part of 'student_home_screen_bloc.dart';

class StudentHomeScreenState {
  final int index;
  const StudentHomeScreenState({
    this.index = 0,
  });

  // StudentHomeScreenState copyWith({
  //   int? index,
  // }) {
  //   return HomePageDotChangeSuccessful(
  //     index: index ?? this.index,
  //   );
  // }
}

final class StudentHomeScreenInitial extends StudentHomeScreenState {}

// Home Page Dot change
// final class HomePageDotChangeSuccessful extends StudentHomeScreenState {
//   final int index;

//   const HomePageDotChangeSuccessful({
//     this.index = 0,
//   });

//   HomePageDotChangeSuccessful copyWith({
//     int? index,
//   }) {
//     return HomePageDotChangeSuccessful(
//       index: index ?? this.index,
//     );
//   }
// }

// Get All Courses

final class HomePageGetAllCoursesLoading extends StudentHomeScreenState {}

final class HomePageGetAllCoursesSuccess extends StudentHomeScreenState {
  final List<CourseItem> courses;
  const HomePageGetAllCoursesSuccess({required this.courses});
}

final class HomePageGetAllCoursesError extends StudentHomeScreenState {
  final String error;

  const HomePageGetAllCoursesError({required this.error});
}
