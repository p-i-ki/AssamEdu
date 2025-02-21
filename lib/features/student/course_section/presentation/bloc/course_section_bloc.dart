import 'package:assam_edu/core/entities/course.dart';
import 'package:assam_edu/features/student/course_section/domain/use_cases/get_course_videos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'course_section_event.dart';
part 'course_section_state.dart';

class CourseSectionBloc extends Bloc<CourseSectionEvent, CourseSectionState> {
  final GetCourseVideos _getCourseVideos;
  CourseSectionBloc({required GetCourseVideos getCourseVideos})
      : _getCourseVideos = getCourseVideos,
        super(CourseSectionInitial()) {
    // on<CourseSectionEvent>((event, emit) {});
    on<CourseVideoFetch>(_getVideos);
  }

  void _getVideos(
      CourseVideoFetch event, Emitter<CourseSectionState> emit) async {
    // emit loading state..
    emit(CourseVideoFetchLoading());
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
