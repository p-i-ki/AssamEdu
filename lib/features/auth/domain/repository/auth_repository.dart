import 'package:assam_edu/core/entities/user.dart';
import 'package:assam_edu/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserSignUpResponseEntity>> signUpWithEmailPassword(
      {required UserSignUpRequestEntity user});

  Future<Either<Failure, UserSignInResponseEntity>> signInWithEmailPassword(
      {required UserSignInRequestEntity user});

  Future<Either<Failure, UserOtpSendResponseEntity>> sendOtpToEmail(
      {required UserOtpSendRequestEntity user});

  Future<Either<Failure, UserVerifyOtpResponseEntity>> verifyOtp(
      {required UserVerifyOtpRequestEntity user});

  // Future<Either<Failures, User>> currentUser();
}
