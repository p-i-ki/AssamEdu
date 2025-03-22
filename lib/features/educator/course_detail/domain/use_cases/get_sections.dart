import 'package:fpdart/fpdart.dart';

import '../../../../../core/entities/course.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/use_case/use_case.dart';
import '../repository/get_sections_repository.dart';

class GetSections
    implements UseCase<CourseVideoResponseEntity, GetSectionsParams> {
  final GetSectionsRepository getSectionsRepository;

  GetSections({required this.getSectionsRepository});
  @override
  Future<Either<Failure, CourseVideoResponseEntity>> call(
      GetSectionsParams params) {
    final courseReq = CourseVideoRequestEntity(courseId: params.courseId);
    return getSectionsRepository.getSections(req: courseReq);
  }
}

class GetSectionsParams {
  String? courseId;
  GetSectionsParams({
    required this.courseId,
  });
}
