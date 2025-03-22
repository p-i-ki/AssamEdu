import 'package:assam_edu/features/educator/add_sections/data/model/add_section_model.dart';
import 'package:assam_edu/features/educator/add_sections/domain/entity/add_section.dart';

class AddSectionMapper {
  static AddSectionNameReqModel toAddSecNameModel(AddSectionNameReqEntity req) {
    return AddSectionNameReqModel(
      sectionName: req.sectionName,
      courseId: req.courseId,
    );
  }

  static AddSectionNameResEntity toAddSecNameEntity(
      AddSectionNameResModel res) {
    return AddSectionNameResEntity(
      success: res.success,
      message: res.message,
      instructor: res.instructor,
      course: res.course,
      sections: res.sections,
    );
  }

  static AddSectionVideoReqModel toAddSecVideoModel(
      AddSectionVideoReqEntity req) {
    return AddSectionVideoReqModel(
      sectionId: req.sectionId,
      courseId: req.courseId,
      video: req.video,
      title: req.title,
    );
  }

  static AddSectionVideoResEntity toAddSecVideoEntity(
      AddSectionVideoResModel res) {
    return AddSectionVideoResEntity(
      message: res.message,
      video: res.video,
      success: res.success,
    );
  }
}
