part of 'eudcator_profile_bloc.dart';

@immutable
sealed class EudcatorProfileState {}

final class EudcatorProfileInitial extends EudcatorProfileState {}

final class EudcatorProfileLoading extends EudcatorProfileState {}

final class EudcatorProfileSuccess extends EudcatorProfileState {
  final Profile profile;

  EudcatorProfileSuccess({required this.profile});
}

final class EudcatorProfileError extends EudcatorProfileState {
  final String error;

  EudcatorProfileError({required this.error});
}
