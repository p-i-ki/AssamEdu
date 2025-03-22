import 'package:assam_edu/features/educator/course_detail/domain/use_cases/get_sections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/entities/course.dart';

part 'educator_course_detail_screen_event.dart';
part 'educator_course_detail_screen_state.dart';

class EducatorCourseDetailScreenBloc extends Bloc<
    EducatorCourseDetailScreenEvent, EducatorCourseDetailScreenState> {
  final GetSections _getSections;
  EducatorCourseDetailScreenBloc({
    required GetSections getSections,
  })  : _getSections = getSections,
        super(EducatorCourseDetailScreenInitial()) {
    on<GetEducatorCourseSections>(_getSecs);
  }

  void _getSecs(GetEducatorCourseSections event,
      Emitter<EducatorCourseDetailScreenState> emit) async {
    emit(EducatorGetCourseSectionLoading());
    final response =
        await _getSections(GetSectionsParams(courseId: event.req.courseId));

    response.fold(
        (error) => emit(EducatorGetCourseSectionError(error: error.message)),
        (success) {
      if (success.success!) {
        return emit(EducatorGetCourseSectionSuccess(res: success.course!));
      }
      return emit(
          const EducatorGetCourseSectionError(error: "Unexpected error!"));
    });
  }
}
