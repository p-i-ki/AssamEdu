import 'package:assam_edu/core/entities/course.dart';
import 'package:assam_edu/features/student/student_home/domain/use_cases/get_all_courses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'student_home_screen_event.dart';
part 'student_home_screen_state.dart';

class StudentHomeScreenBloc
    extends Bloc<StudentHomeScreenEvent, StudentHomeScreenState> {
  final GetAllCourses _getAllCourses;
  StudentHomeScreenBloc({
    required GetAllCourses getAllCourses,
  })  : _getAllCourses = getAllCourses,
        super(StudentHomeScreenInitial()) {
    //on<StudentHomeScreenEvent>((event, emit) {});
    on<HomePageGetAllCourses>(_getCourses);
    on<HomePageDotsChange>(_changeHomePageDots);
  }

  void _changeHomePageDots(
    HomePageDotsChange event,
    Emitter<StudentHomeScreenState> emit,
  ) {
    emit(StudentHomeScreenState(index: event.index));
  }

  void _getCourses(
    HomePageGetAllCourses event,
    Emitter<StudentHomeScreenState> emit,
  ) async {
    // Emit loading state..
    emit(HomePageGetAllCoursesLoading());
    final response =
        await _getAllCourses(GetAllCourseParams(token: event.courseReq.token));

    response
        .fold((error) => emit(HomePageGetAllCoursesError(error: error.message)),
            (success) {
      if (success.success!) {
        return emit(
            HomePageGetAllCoursesSuccess(courses: success.courseItems!));
      }
      return emit(
          const HomePageGetAllCoursesError(error: "Unexpected error occured!"));
    });
  }
}
