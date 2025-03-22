import 'package:assam_edu/features/educator/educator_home/domain/entity/instructor_course_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/get_instructor_courses.dart';

part 'educator_home_screen_event.dart';
part 'educator_home_screen_state.dart';

class EducatorHomeScreenBloc
    extends Bloc<EducatorHomeScreenEvent, EducatorHomeScreenState> {
  final GetInstructorCourses _getInstructorCourses;
  EducatorHomeScreenBloc({
    required GetInstructorCourses getInstructor,
  })  : _getInstructorCourses = getInstructor,
        super(EducatorHomeScreenInitial()) {
    on<GetCoursesEvent>(_getCourses);
  }

  void _getCourses(
      GetCoursesEvent event, Emitter<EducatorHomeScreenState> emit) async {
    emit(EducatorHomeScreenLoading());
    final res = await _getInstructorCourses(NoParams());
    res.fold((error) => emit(EducatorGetCourseError(error: error.message)),
        (success) {
      if (success.success == true) {
        return emit(EducatorGetCourseSuccess(res: success));
      }
      return emit(EducatorGetCourseError(error: success.message!));
    });
  }
}
