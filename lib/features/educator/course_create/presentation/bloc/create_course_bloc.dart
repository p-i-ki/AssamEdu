import 'package:assam_edu/features/educator/course_create/domain/entities/create_course.dart';
import 'package:assam_edu/features/educator/course_create/domain/use_cases/create_course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_course_event.dart';
part 'create_course_state.dart';

class CreateCourseBloc extends Bloc<CreateCourseEvent, CreateCourseState> {
  final CreateCourse _createCourse;
  CreateCourseBloc({
    required CreateCourse createCourse,
  })  : _createCourse = createCourse,
        super(CreateCourseInitial()) {
    on<AddCourse>(_addCourse);
  }

  void _addCourse(AddCourse event, Emitter<CreateCourseState> emit) async {
    emit(CreateCourseLoading());
    final res = await _createCourse(CreateCourseParams(
      title: event.course.title,
      description: event.course.description,
      category: event.course.category,
      tags: event.course.tags,
      thumbnail: event.course.thumbnail,
      price: event.course.price,
    ));

    res.fold((error) => emit(CreateCourseError(error: error.message)),
        (success) {
      if (success.success) {
        return emit(CreateCourseSuccess(response: success.course));
      }
      return emit(
          CreateCourseError(error: "Can't Create course! please try again"));
    });
  }
}
