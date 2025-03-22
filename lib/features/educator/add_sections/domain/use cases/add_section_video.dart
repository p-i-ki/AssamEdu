// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:fpdart/fpdart.dart';

import 'package:assam_edu/core/error/failure.dart';
import 'package:assam_edu/core/use_case/use_case.dart';
import 'package:assam_edu/features/educator/add_sections/domain/entity/add_section.dart';
import 'package:assam_edu/features/educator/add_sections/domain/repository/add_section_repository.dart';

class AddSectionVideo
    implements UseCase<AddSectionVideoResEntity, AddSectionVideoParams> {
  final AddSectionRepository addSectionRepository;
  AddSectionVideo(this.addSectionRepository);
  @override
  Future<Either<Failure, AddSectionVideoResEntity>> call(
      AddSectionVideoParams params) async {
    final video = AddSectionVideoReqEntity(
      sectionId: params.sectionId,
      courseId: params.courseId,
      video: params.video,
      title: params.title,
    );
    return await addSectionRepository.uploadSectionVideo(req: video);
  }
}

class AddSectionVideoParams {
  final String sectionId;
  final String courseId;
  final File video;
  final String title;

  AddSectionVideoParams({
    required this.sectionId,
    required this.courseId,
    required this.video,
    required this.title,
  });
}
