import 'package:assam_edu/features/course/course_create/domain/entities/create_course.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_course_event.dart';
part 'create_course_state.dart';

class CreateCourseBloc extends Bloc<CreateCourseEvent, CreateCourseState> {
  CreateCourseBloc() : super(CreateCourseInitial()) {
    on<CreateCourseEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
