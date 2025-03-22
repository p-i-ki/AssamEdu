part of 'add_section_bloc.dart';

@immutable
sealed class AddSectionEvent {}

final class AddSectionNameEvent extends AddSectionEvent {
  final String sectionName;
  final String courseId;

  AddSectionNameEvent({
    required this.sectionName,
    required this.courseId,
  });
}

final class AddSectionVideoEvent extends AddSectionEvent {
  final String sectionId;
  final String courseId;
  final File video;
  final String title;

  AddSectionVideoEvent({
    required this.sectionId,
    required this.courseId,
    required this.video,
    required this.title,
  });
}
