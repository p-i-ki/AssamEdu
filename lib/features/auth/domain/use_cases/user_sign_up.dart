import 'package:assam_edu/core/entities/user.dart';
import 'package:assam_edu/core/error/failure.dart';
import 'package:assam_edu/core/use_case/use_case.dart';
import 'package:assam_edu/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp
    implements UseCase<UserSignUpResponseEntity, UserSignUpParams> {
  final AuthRepository authRepository;
  UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, UserSignUpResponseEntity>> call(
    UserSignUpParams params,
  ) async {
    final user =
        UserSignUpRequestEntity(email: params.email, password: params.password);
    return await authRepository.signUpWithEmailPassword(
      user: user,
    );
  }
}

//we are creating this class as we need to pass three parameters but UseCase takes only one ..
class UserSignUpParams {
  final String email;
  final String password;

  UserSignUpParams({
    required this.email,
    required this.password,
  });
}
