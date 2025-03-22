part of 'add_section_bloc.dart';

@immutable
sealed class AddSectionState {}

final class AddSectionInitial extends AddSectionState {}

final class AddSectionNameLoading extends AddSectionState {}

final class AddSectionNameSuccess extends AddSectionState {
  final AddSectionNameResEntity res;

  AddSectionNameSuccess({required this.res});
}

final class AddSectionNameError extends AddSectionState {
  final String error;

  AddSectionNameError({required this.error});
}

//Video

final class AddSectionVideoLoading extends AddSectionState {}

final class AddSectionVideoSuccess extends AddSectionState {
  final AddSectionVideoResEntity res;

  AddSectionVideoSuccess({required this.res});
}

final class AddSectionVideoError extends AddSectionState {
  final String error;

  AddSectionVideoError({required this.error});
}
