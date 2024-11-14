import 'package:assam_edu/core/entities/user.dart';
import 'package:assam_edu/core/error/exceptions.dart';
import 'package:assam_edu/core/error/failure.dart';
import 'package:assam_edu/features/auth/data/data_resources/auth_remote_data_source.dart';
import 'package:assam_edu/features/auth/data/models/auth_mapper.dart';
import 'package:assam_edu/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl(this.authRemoteDataSource);
  @override
  Future<Either<Failure, UserSignUpResponseEntity>> signUpWithEmailPassword({
    required UserSignUpRequestEntity user,
  }) async {
    try {
      // converting domain entity to data model
      final requestModel = AuthMapper.toModel(user);
      final responseModel = await authRemoteDataSource.signUpWithEmailPassword(
          user: requestModel);
      // Convert data model back to domain entity
      final responseEntity = AuthMapper.toEntity(responseModel);
      return right(responseEntity);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserSignInResponseEntity>> signInWithEmailPassword(
      {required UserSignInRequestEntity user}) async {
    try {
      // converting domain entity to data model
      final requestModel = AuthMapper.toModelSignIn(user);
      final responseModel = await authRemoteDataSource.signInWithEmailPassword(
          user: requestModel);
      // Convert data model back to domain entity
      final responseEntity = AuthMapper.toEntitySignIn(responseModel);
      return right(responseEntity);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserOtpSendResponseEntity>> sendOtpToEmail(
      {required UserOtpSendRequestEntity user}) async {
    try {
      // converting domain entity to data model
      final requestModel = AuthMapper.toModelSendOtp(user);
      final responseModel =
          await authRemoteDataSource.sendOtpToEmail(user: requestModel);
      // Convert data model back to domain entity
      final responseEntity = AuthMapper.toEntitySendotp(responseModel);
      return right(responseEntity);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserVerifyOtpResponseEntity>> verifyOtp(
      {required UserVerifyOtpRequestEntity user}) async {
    try {
      final requestModel = AuthMapper.toModelVerifyOtp(user);
      final responseModel =
          await authRemoteDataSource.verifyOtp(user: requestModel);
      final responseEntity = AuthMapper.toEntityVerifyOtp(responseModel);
      return right(responseEntity);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
