import 'package:assam_edu/core/entities/user.dart';
import 'package:assam_edu/core/error/failure.dart';
import 'package:assam_edu/core/use_case/use_case.dart';
import 'package:assam_edu/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignIn
    implements UseCase<UserSignInResponseEntity, UserSignInParams> {
  final AuthRepository authRepository;
  UserSignIn(this.authRepository);
  @override
  Future<Either<Failure, UserSignInResponseEntity>> call(
      UserSignInParams params) async {
    final user = UserSignInRequestEntity(
      email: params.email,
      password: params.password,
    );
    return await authRepository.signInWithEmailPassword(
      user: user,
    );
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({
    required this.email,
    required this.password,
  });
}
