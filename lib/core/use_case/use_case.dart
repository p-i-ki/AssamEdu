import 'package:assam_edu/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

//we are taking succesType and Params from the implementing class..Because it is different for different classes..
abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}
