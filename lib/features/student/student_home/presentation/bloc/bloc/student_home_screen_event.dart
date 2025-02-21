part of 'student_home_screen_bloc.dart';

@immutable
sealed class StudentHomeScreenEvent {
  const StudentHomeScreenEvent();
}

class HomePageDotsChange extends StudentHomeScreenEvent {
  final int index;
  const HomePageDotsChange({required this.index});
}

class HomePageGetAllCourses extends StudentHomeScreenEvent {
  final CourseListRequestEntity courseReq;
  const HomePageGetAllCourses({required this.courseReq});
}
