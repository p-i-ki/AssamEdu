import 'package:assam_edu/core/error/failure.dart';
import 'package:assam_edu/features/educator/add_sections/domain/entity/add_section.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AddSectionRepository {
  Future<Either<Failure, AddSectionNameResEntity>> uploadSectionName(
      {required AddSectionNameReqEntity req});

  Future<Either<Failure, AddSectionVideoResEntity>> uploadSectionVideo(
      {required AddSectionVideoReqEntity req});
}
