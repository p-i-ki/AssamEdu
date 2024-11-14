import 'package:assam_edu/core/entities/user.dart';
import 'package:assam_edu/core/error/failure.dart';
import 'package:assam_edu/core/use_case/use_case.dart';
import 'package:assam_edu/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSendOtp
    implements UseCase<UserOtpSendResponseEntity, UserSendOtpParams> {
  final AuthRepository authRepository;
  UserSendOtp(this.authRepository);
  @override
  Future<Either<Failure, UserOtpSendResponseEntity>> call(
      UserSendOtpParams params) async {
    final user = UserOtpSendRequestEntity(
      email: params.email,
    );
    return await authRepository.sendOtpToEmail(
      user: user,
    );
  }
}

class UserSendOtpParams {
  final String email;

  UserSendOtpParams({
    required this.email,
  });
}
