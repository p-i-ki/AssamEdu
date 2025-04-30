part of 'eudcator_profile_bloc.dart';

@immutable
sealed class EudcatorProfileEvent {}

final class EducatorProfileCreateEvent extends EudcatorProfileEvent {
  final String bio;
  final String qualification;
  final File profilePicture;

  EducatorProfileCreateEvent({
    required this.bio,
    required this.qualification,
    required this.profilePicture,
  });
}
