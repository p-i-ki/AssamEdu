import 'dart:io';

import 'package:assam_edu/features/educator/add_sections/domain/entity/add_section.dart';
import 'package:assam_edu/features/educator/add_sections/domain/use%20cases/add_section_name.dart';
import 'package:assam_edu/features/educator/add_sections/domain/use%20cases/add_section_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_section_event.dart';
part 'add_section_state.dart';

class AddSectionBloc extends Bloc<AddSectionEvent, AddSectionState> {
  final AddSectionName _addSectionName;
  final AddSectionVideo _addSectionVideo;
  AddSectionBloc({
    required AddSectionName addSectionName,
    required AddSectionVideo addSectionVideo,
  })  : _addSectionName = addSectionName,
        _addSectionVideo = addSectionVideo,
        super(AddSectionInitial()) {
    on<AddSectionNameEvent>(_addSecName);
    on<AddSectionVideoEvent>(_addSecVideo);
  }

  void _addSecName(
    AddSectionNameEvent event,
    Emitter<AddSectionState> emit,
  ) async {
    emit(AddSectionNameLoading());
    final res = await _addSectionName(AddSectionNameParams(
      sectionName: event.sectionName,
      courseId: event.courseId,
    ));

    res.fold((error) => emit(AddSectionNameError(error: error.message)),
        (success) {
      if (success.success == true) {
        return emit(AddSectionNameSuccess(res: success));
      }
      return emit(AddSectionNameError(error: success.message!));
    });
  }

  void _addSecVideo(
    AddSectionVideoEvent event,
    Emitter<AddSectionState> emit,
  ) async {
    emit(AddSectionVideoLoading());
    final res = await _addSectionVideo(AddSectionVideoParams(
      sectionId: event.sectionId,
      courseId: event.courseId,
      video: event.video,
      title: event.title,
    ));

    res.fold((error) => emit(AddSectionVideoError(error: error.message)),
        (success) {
      if (success.success == true) {
        return emit(AddSectionVideoSuccess(res: success));
      }
      return emit(AddSectionVideoError(error: success.message!));
    });
  }
}
