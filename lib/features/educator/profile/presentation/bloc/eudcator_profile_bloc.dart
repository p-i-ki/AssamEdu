import 'dart:io';

import 'package:assam_edu/features/educator/profile/domain/entities/educator_profile.dart';
import 'package:assam_edu/features/educator/profile/domain/use_cases/create_educator_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'eudcator_profile_event.dart';
part 'eudcator_profile_state.dart';

class EudcatorProfileBloc
    extends Bloc<EudcatorProfileEvent, EudcatorProfileState> {
  final CreateEducatorProfile _createEducatorProfile;
  EudcatorProfileBloc({
    required CreateEducatorProfile createEducatorPrifle,
  })  : _createEducatorProfile = createEducatorPrifle,
        super(EudcatorProfileInitial()) {
    on<EducatorProfileCreateEvent>(_addProfile);
  }

  void _addProfile(EducatorProfileCreateEvent event,
      Emitter<EudcatorProfileState> emit) async {
    emit(EudcatorProfileLoading());
    final res = await _createEducatorProfile(CreateProfileParams(
      bio: event.bio,
      profilePicture: event.profilePicture,
      qualification: event.qualification,
    ));

    res.fold((error) => emit(EudcatorProfileError(error: error.message)),
        (success) {
      if (success.success) {
        return emit(EudcatorProfileSuccess(profile: success.profile));
      }
      return emit(
          EudcatorProfileError(error: "Can't Create prfile! please try again"));
    });
  }
}
