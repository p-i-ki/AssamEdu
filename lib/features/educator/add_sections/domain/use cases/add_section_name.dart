import 'package:assam_edu/core/error/failure.dart';
import 'package:assam_edu/core/use_case/use_case.dart';
import 'package:assam_edu/features/educator/add_sections/domain/entity/add_section.dart';
import 'package:assam_edu/features/educator/add_sections/domain/repository/add_section_repository.dart';
import 'package:fpdart/fpdart.dart';

class AddSectionName
    implements UseCase<AddSectionNameResEntity, AddSectionNameParams> {
  final AddSectionRepository addSectionRepository;
  AddSectionName(this.addSectionRepository);
  @override
  Future<Either<Failure, AddSectionNameResEntity>> call(
      AddSectionNameParams params) async {
    final section = AddSectionNameReqEntity(
      sectionName: params.sectionName,
      courseId: params.courseId,
    );
    return await addSectionRepository.uploadSectionName(req: section);
  }
}

class AddSectionNameParams {
  final String sectionName;
  final String courseId;

  AddSectionNameParams({
    required this.sectionName,
    required this.courseId,
  });
}
