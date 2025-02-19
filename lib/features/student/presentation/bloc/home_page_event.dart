part of 'home_page_bloc.dart';

@immutable
sealed class HomePageEvent {
  const HomePageEvent();
}

class HomePageDotsChange extends HomePageEvent {
  final int index;
  const HomePageDotsChange({required this.index});
}

class HomePageGetAllCourses extends HomePageEvent {
  final CourseListRequestEntity courseReq;
  const HomePageGetAllCourses({required this.courseReq});
}

class CourseVideoFetch extends HomePageEvent {
  final CourseVideoRequestEntity requestEntity;

  const CourseVideoFetch({required this.requestEntity});
}
