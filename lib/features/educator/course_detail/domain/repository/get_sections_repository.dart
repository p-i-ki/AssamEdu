import 'package:assam_edu/core/entities/course.dart';
import 'package:assam_edu/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class GetSectionsRepository {
  Future<Either<Failure, CourseVideoResponseEntity>> getSections(
      {required CourseVideoRequestEntity req});
}
