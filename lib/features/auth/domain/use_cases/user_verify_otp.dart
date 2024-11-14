import 'package:assam_edu/core/entities/user.dart';
import 'package:assam_edu/core/error/failure.dart';
import 'package:assam_edu/core/use_case/use_case.dart';
import 'package:assam_edu/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserVerifyOtp
    implements UseCase<UserVerifyOtpResponseEntity, UserVerifyOtpParams> {
  final AuthRepository authRepository;
  UserVerifyOtp(this.authRepository);
  @override
  Future<Either<Failure, UserVerifyOtpResponseEntity>> call(
      UserVerifyOtpParams params) async {
    final user = UserVerifyOtpRequestEntity(
      email: params.email,
      otp: params.otp,
    );
    return await authRepository.verifyOtp(
      user: user,
    );
  }
}

class UserVerifyOtpParams {
  final String email;
  final String otp;

  UserVerifyOtpParams({
    required this.email,
    required this.otp,
  });
}
