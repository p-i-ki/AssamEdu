import 'package:assam_edu/features/student/domain/entity/course.dart';
import 'package:assam_edu/features/student/domain/use_cases/get_all_courses.dart';
import 'package:assam_edu/features/student/domain/use_cases/get_course_videos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final GetAllCourses _getAllCourses;
  final GetCourseVideos _getCourseVideos;
  HomePageBloc({
    required GetAllCourses getAllCourses,
    required GetCourseVideos getCourseVideos,
  })  : _getAllCourses = getAllCourses,
        _getCourseVideos = getCourseVideos,
        super(const HomePageInitial()) {
    on<HomePageEvent>((_, emit) {
      emit(HomePageLoading());
    });
    on<HomePageDotsChange>(_changeHomePageDots);
    on<HomePageGetAllCourses>(_getCourses);
    on<CourseVideoFetch>(_getVideos);
  }

  void _changeHomePageDots(
    HomePageDotsChange event,
    Emitter<HomePageState> emit,
  ) {
    emit(HomePageInitial(index: event.index));
  }

  void _getCourses(
    HomePageGetAllCourses event,
    Emitter<HomePageState> emit,
  ) async {
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

  void _getVideos(CourseVideoFetch event, Emitter<HomePageState> emit) async {
    final response = await _getCourseVideos(
        GetCourseVideoParams(courseId: event.requestEntity.courseId));

    response.fold((error) => emit(CourseVideoFetchError(error: error.message)),
        (success) {
      if (success.success!) {
        return emit(CourseVideoFetchSuccess(responseEntity: success.course!));
      }
      return emit(const CourseVideoFetchError(error: "Unexpected error!"));
    });
  }
}
